framework 'Foundation'
require File.expand_path("../format", __FILE__)

class MRDate < NSDate
  JULIAN_DAY_FORMATTER = NSDateFormatter.new
  JULIAN_DAY_FORMATTER.dateFormat = "g"
  
  GREGORIAN_CALENDAR = NSCalendar.alloc.initWithCalendarIdentifier(NSGregorianCalendar)
  PARSE_COMPONENTS = NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit
  
  BC = 0
  AD = 1
  
  ##
  #
  # original date.rb constants:
  #
  
  # Full month names, in English.  Months count from 1 to 12; a
  # month's numerical representation indexed into this array
  # gives the name of that month (hence the first element is nil).
  MONTHNAMES = [nil] + %w(January February March April May June July
                          August September October November December)

  # Full names of days of the week, in English.  Days of the week
  # count from 0 to 6 (except in the commercial week); a day's numerical
  # representation indexed into this array gives the name of that day.
  DAYNAMES = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)

  # Abbreviated month names, in English.
  ABBR_MONTHNAMES = [nil] + %w(Jan Feb Mar Apr May Jun
                               Jul Aug Sep Oct Nov Dec)

  # Abbreviated day names, in English.
  ABBR_DAYNAMES = %w(Sun Mon Tue Wed Thu Fri Sat)

  [MONTHNAMES, DAYNAMES, ABBR_MONTHNAMES, ABBR_DAYNAMES].each do |xs|
    xs.each{|x| x.freeze unless x.nil?}.freeze
  end
  
  # The Julian Day Number of the Day of Calendar Reform for Italy
  # and the Catholic countries.
  # ITALY = 2299161 # 1582-10-15
  ITALY = JULIAN_DAY_FORMATTER.dateFromString("2299161").timeIntervalSinceReferenceDate # 1582-10-15
  
  # The Julian Day Number of the Day of Calendar Reform for England
  # and her Colonies.
  # ENGLAND   = 2361222 # 1752-09-14
  ENGLAND = JULIAN_DAY_FORMATTER.dateFromString("2361222").timeIntervalSinceReferenceDate # 1752-09-14
  
  ##
  #
  # Obligatory NSDate overrides
  #
  
  def init
    if super
      @offset = 0
      @sg = ITALY
      self
    end
  end
  
  def initWithTimeIntervalSinceReferenceDate(seconds)
    if init
      @offset = seconds
      self
    end
  end
  
  def timeIntervalSinceReferenceDate
    @offset
  end
  
  ##
  #
  # Implementation
  #
  
  class << self
    # to handle negative values we need to know the last day of the month,
    # see: http://www.cocoabuilder.com/archive/cocoa/180554-getting-the-last-date-of-the-month.html
    def valid_civil?(year, month, day, sg = ITALY)
      case sg
      when ITALY
        # In 1582 in Italy, 4th October was followed by 15th October, skipping 10 days.
        !(year == 1582 && month == 10 && day > 4 && day < 15)
      when ENGLAND
        # In 1752 in England, 2nd September was followed by 14th September, skipping 11 days.
        # !(year == 1752 && month == 9 && day > 2 && day < 14)
        raise "not dealing with any other reform date than ITALY yet"
      end
    end
    
    # conform to the rubyspecs, don't wrap around
    def new(year = -4712, month = 1, day = 1, sg = ITALY)
      # we can catch this here already
      raise ArgumentError, "invalid date" if month > 12
      
      unless valid_civil?(year, month, day, sg)
        raise ArgumentError, "invalid date, because it falls in the dropped days range of the calendar reform"
      end
      
      components = NSDateComponents.new
      components.year = year
      components.month = month
      components.day = day
      
      # TODO: check when this can return `nil' instead of a date
      date = GREGORIAN_CALENDAR.dateFromComponents(components)
      interval = date.timeIntervalSinceReferenceDate
      
      mrdate = alloc.initWithTimeIntervalSinceReferenceDate(interval)
      mrdate.sg = sg
      
      # no positive wrap around!
      if mrdate.day < day && (mrdate.month == (month + 1) % 12)
        raise ArgumentError, "invalid date"
      end
      
      mrdate
    end
    
    alias_method :civil, :new
  end
end

module MRDateAPI
  include Comparable
  
  attr_accessor :sg
  
  def eql?(other)
    compare(other) == NSOrderedSame
  end
  alias_method :==, :eql?
  
  # If +x+ is a Numeric value, create a new Date object that is
  # +x+ days earlier than the current one.
  #
  # If +x+ is a Date, return the number of days between the
  # two dates; or, more precisely, how many days later the current
  # date is than +x+.
  #
  # If +x+ is neither Numeric nor a Date, a TypeError is raised.
  def -(x)
    case x
    when Numeric
      date_with_offset(-x, :day)
    when NSDate
      components = calendar.components(NSDayCalendarUnit, fromDate: x, toDate: self, options: 0)
      components.day
    else
      raise TypeError, "expected numeric or date"
    end
  end
  
  # Return a new Date object that is +n+ days later than the
  # current one.
  #
  # +n+ may be a negative value, in which case the new Date
  # is earlier than the current one; however, #-() might be
  # more intuitive.
  #
  # If +n+ is not a Numeric, a TypeError will be thrown.  In
  # particular, two Dates cannot be added to each other.
  def +(x)
    date_with_offset(x, :day)
  end
  
  # Return a new Date object that is +n+ months earlier than
  # the current one.
  #
  # If the day-of-the-month of the current Date is greater
  # than the last day of the target month, the day-of-the-month
  # of the returned Date will be the last day of the target month.
  def <<(n)
    date_with_offset(-n, :month)
  end
  
  # Return a new Date object that is +n+ months later than
  # the current one.
  #
  # If the day-of-the-month of the current Date is greater
  # than the last day of the target month, the day-of-the-month
  # of the returned Date will be the last day of the target month.
  def >>(n)
    date_with_offset(n, :month)
  end
  
  # Compare this date with another date.
  #
  # +other+ can also be a Numeric value, in which case it is
  # interpreted as an Astronomical Julian Day Number.
  def <=>(x)
    case x
    when Numeric
      jd.compare(x)
    when NSDate
      compare(x)
    end
  end
  
  def year
    components.era == MRDate::BC ? -(components.year - 1) : components.year
  end
  
  def month
    components.month
  end
  alias_method :mon, :month
  
  def day
    components.day
  end
  alias_method :mday, :day
  
  # Get the week day of this date.  Sunday is day-of-week 0;
  # Saturday is day-of-week 6.
  def wday
    components.weekday - 1
  end
  
  def hour
    components.hour
  end
  
  def minute
    components.minute
  end
  alias_method :min, :minute
  
  def second
    components.second
  end
  alias_method :sec, :second
  
  # TODO: lazy bastard
  def jd
    MRDate::JULIAN_DAY_FORMATTER.stringFromDate(self).to_i
  end
  
  # returns the julian day if it's a date before the specified calendar reform date
  def julian?
    timeIntervalSinceReferenceDate < @sg
  end
  
  # Step the current date forward +step+ days at a
  # time (or backward, if +step+ is negative) until
  # we reach +limit+ (inclusive), yielding the resultant
  # date at each step.
  def step(limit, step = 1)
    # unless block_given?
    #   return to_enum(:step, limit, step)
    # end
    da = self
    op = %w(- <= >=)[step <=> 0]
    while da.send(op, limit)
      yield da
      da += step
    end
    self
  end
  
  # Step forward one day at a time until we reach +max+
  # (inclusive), yielding each date as we go.
  def upto(max, &block) # :yield: date
    step(max, +1, &block)
  end
  
  # Step backward one day at a time until we reach +min+
  # (inclusive), yielding each date as we go.
  def downto(min, &block) # :yield: date
    step(min, -1, &block)
  end
  
  # TODO: Not sure what hash is being returned by MacRuby, but it seems to work already...
  # def hash
  #   jd.hash
  # end
  
  ##
  #
  # String methods
  #
  
  # TODO: possibly add something like the following, which could be much faster
  #
  # alias_method :__original_strftime, :strftime
  # def strftime(format = '%F', use_ruby_strftime = true)
  #   if use_ruby_strftime
  #     __original_strftime(format)
  #   else
  #     descriptionWithCalendarFormat(format, timeZone: nil, locale: nil)
  #   end
  # end
  
  def to_s
    # "#{year}-#{month}-#{day}"
    strftime
  end
  
  def inspect
    "#<#{self.class.name} #{to_s}>"
  end
  
  private
  
  def calendar
    MRDate::GREGORIAN_CALENDAR
  end
  
  def components
    calendar.components(MRDate::PARSE_COMPONENTS, fromDate: self)
  end
  
  # asserts x is a numeric and assigns it to the method type, eg year, month, day
  def date_with_offset(x, type)
    raise TypeError, "expected numeric" unless x.is_a?(Numeric)
    
    offset = NSDateComponents.new
    offset.send("#{type}=", x)
    calendar.dateByAddingComponents(offset, toDate: self, options: 0)
  end
end

class NSDate
  include MRDateAPI
end