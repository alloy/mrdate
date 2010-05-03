framework 'Foundation'

class MRTime < NSDate
  ##
  #
  # Obligatory NSDate overrides
  #
  
  def init
    if super
      @offset = 0
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
  # API
  #
  
  class << self
    def new
      date
    end
    alias_method :now, :new
    
    # call-seq:
    #    Time.at(time) => time
    #    Time.at(seconds_with_frac) => time
    #    Time.at(seconds, microseconds_with_frac) => time
    # 
    # Creates a new time object with the value given by <i>time</i>,
    # the given number of <i>seconds_with_frac</i>, or
    # <i>seconds</i> and <i>microseconds_with_frac</i> from the Epoch.
    # <i>seconds_with_frac</i> and <i>microseconds_with_frac</i>
    # can be Integer, Float, Rational, or other Numeric.
    # non-portable feature allows the offset to be negative on some systems.
    #    
    #    Time.at(0)            #=> 1969-12-31 18:00:00 -0600
    #    Time.at(Time.at(0))   #=> 1969-12-31 18:00:00 -0600
    #    Time.at(946702800)    #=> 1999-12-31 23:00:00 -0600
    #    Time.at(-284061600)   #=> 1960-12-31 00:00:00 -0600
    #    Time.at(946684800.2).usec #=> 200000
    #    Time.at(946684800, 123456.789).nsec #=> 123456789
    def at(*x)
      x = x.first if x.size == 1
      case x
      when Numeric
        dateWithTimeIntervalSince1970(x)
      when NSDate
        dateWithTimeIntervalSinceReferenceDate(x.timeIntervalSinceReferenceDate)
      when Array
        sec, usec = x
        interval = sec + (usec.to_f / 1_000_000)
        dateWithTimeIntervalSince1970(interval)
      end
    end
  end
  
  def to_i
    timeIntervalSince1970.round
  end
end

module MRTimeAPI
  # include Comparable
  # 
  # attr_accessor :sg
  # 
  # def eql?(other)
  #   compare(other) == NSOrderedSame
  # end
  # alias_method :==, :eql?
  # 
  # # If +x+ is a Numeric value, create a new Date object that is
  # # +x+ days earlier than the current one.
  # #
  # # If +x+ is a Date, return the number of days between the
  # # two dates; or, more precisely, how many days later the current
  # # date is than +x+.
  # #
  # # If +x+ is neither Numeric nor a Date, a TypeError is raised.
  # def -(x)
  #   case x
  #   when Numeric
  #     date_with_offset(-x, :day)
  #   when NSDate
  #     components = calendar.components(NSDayCalendarUnit, fromDate: x, toDate: self, options: 0)
  #     components.day
  #   else
  #     raise TypeError, "expected numeric or date"
  #   end
  # end
  # 
  # # Return a new Date object that is +n+ days later than the
  # # current one.
  # #
  # # +n+ may be a negative value, in which case the new Date
  # # is earlier than the current one; however, #-() might be
  # # more intuitive.
  # #
  # # If +n+ is not a Numeric, a TypeError will be thrown.  In
  # # particular, two Dates cannot be added to each other.
  # def +(x)
  #   date_with_offset(x, :day)
  # end
  # 
  # # Return a new Date object that is +n+ months earlier than
  # # the current one.
  # #
  # # If the day-of-the-month of the current Date is greater
  # # than the last day of the target month, the day-of-the-month
  # # of the returned Date will be the last day of the target month.
  # def <<(n)
  #   date_with_offset(-n, :month)
  # end
  # 
  # # Return a new Date object that is +n+ months later than
  # # the current one.
  # #
  # # If the day-of-the-month of the current Date is greater
  # # than the last day of the target month, the day-of-the-month
  # # of the returned Date will be the last day of the target month.
  # def >>(n)
  #   date_with_offset(n, :month)
  # end
  # 
  # # Compare this date with another date.
  # #
  # # +other+ can also be a Numeric value, in which case it is
  # # interpreted as an Astronomical Julian Day Number.
  # def <=>(x)
  #   case x
  #   when Numeric
  #     jd.compare(x)
  #   when NSDate
  #     compare(x)
  #   end
  # end
  
  BC = 0
  AD = 1
  
  def year
    components.era == BC ? -(components.year - 1) : components.year
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
  
  def usec
    interval = timeIntervalSince1970
    decimals = interval - interval.to_i
    (decimals * 1_000_000).round
  end
  
  # # TODO: lazy bastard
  # def jd
  #   MRDate::JULIAN_DAY_FORMATTER.stringFromDate(self).to_i
  # end
  # 
  # # returns the julian day if it's a date before the specified calendar reform date
  # def julian?
  #   timeIntervalSinceReferenceDate < @sg
  # end
  # 
  # # Step the current date forward +step+ days at a
  # # time (or backward, if +step+ is negative) until
  # # we reach +limit+ (inclusive), yielding the resultant
  # # date at each step.
  # def step(limit, step = 1)
  #   # unless block_given?
  #   #   return to_enum(:step, limit, step)
  #   # end
  #   da = self
  #   op = %w(- <= >=)[step <=> 0]
  #   while da.send(op, limit)
  #     yield da
  #     da += step
  #   end
  #   self
  # end
  # 
  # # Step forward one day at a time until we reach +max+
  # # (inclusive), yielding each date as we go.
  # def upto(max, &block) # :yield: date
  #   step(max, +1, &block)
  # end
  # 
  # # Step backward one day at a time until we reach +min+
  # # (inclusive), yielding each date as we go.
  # def downto(min, &block) # :yield: date
  #   step(min, -1, &block)
  # end
  # 
  # # TODO: Not sure what hash is being returned by MacRuby, but it seems to work already...
  # # def hash
  # #   jd.hash
  # # end
  # 
  # ##
  # #
  # # String methods
  # #
  # 
  # # TODO: possibly add something like the following, which could be much faster
  # #
  # # alias_method :__original_strftime, :strftime
  # # def strftime(format = '%F', use_ruby_strftime = true)
  # #   if use_ruby_strftime
  # #     __original_strftime(format)
  # #   else
  # #     descriptionWithCalendarFormat(format, timeZone: nil, locale: nil)
  # #   end
  # # end
  
  def to_s
    # TODO this breaks the minus spec: strftime
    format "#{year}-%02d-%02d %02d:%02d:%02d +0200", month, day, hour, minute, second
  end
  alias_method :inspect, :to_s
  
  private
  
  GREGORIAN_CALENDAR = NSCalendar.alloc.initWithCalendarIdentifier(NSGregorianCalendar)
  
  def calendar
    GREGORIAN_CALENDAR
  end
  
  PARSE_COMPONENTS = NSEraCalendarUnit | NSYearCalendarUnit |
    NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit
  
  def components
    calendar.components(PARSE_COMPONENTS, fromDate: self)
  end
  
  # # asserts x is a numeric and assigns it to the method type, eg year, month, day
  # def date_with_offset(x, type)
  #   raise TypeError, "expected numeric" unless x.is_a?(Numeric)
  #   
  #   offset = NSDateComponents.new
  #   offset.send("#{type}=", x)
  #   calendar.dateByAddingComponents(offset, toDate: self, options: 0)
  # end
end

class NSDate
  include MRTimeAPI
end