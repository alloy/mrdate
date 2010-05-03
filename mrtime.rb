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
end

module MRTimeAPI
  include Comparable
  
  # call-seq:
  #    time <=> other_time => -1, 0, +1 
  # 
  # Comparison---Compares <i>time</i> with <i>other_time</i>.
  #    
  #    t = Time.now       #=> 2007-11-19 08:12:12 -0600
  #    t2 = t + 2592000   #=> 2007-12-19 08:12:12 -0600
  #    t <=> t2           #=> -1
  #    t2 <=> t           #=> 1
  #    
  #    t = Time.now       #=> 2007-11-19 08:13:38 -0600
  #    t2 = t + 0.1       #=> 2007-11-19 08:13:38 -0600
  #    t.nsec             #=> 98222999
  #    t2.nsec            #=> 198222999
  #    t <=> t2           #=> -1
  #    t2 <=> t           #=> 1
  #    t <=> t            #=> 0
  def <=>(time)
    # timeIntervalSinceReferenceDate <=> time.timeIntervalSinceReferenceDate if time.is_a?(NSDate)
    compare(time) if time.is_a?(NSDate)
  end
  
  def eql?(other)
    compare(other) == NSOrderedSame
  end
  alias_method :==, :eql?
  
  # call-seq:
  #    time - other_time => float
  #    time - numeric    => time
  # 
  # Difference---Returns a new time that represents the difference
  # between two times, or subtracts the given number of seconds in
  # <i>numeric</i> from <i>time</i>.
  #    
  #    t = Time.now       #=> 2007-11-19 08:23:10 -0600
  #    t2 = t + 2592000   #=> 2007-12-19 08:23:10 -0600
  #    t2 - t             #=> 2592000.0
  #    t2 - 2592000       #=> 2007-11-19 08:23:10 -0600
  def -(x)
    if x.is_a?(NSDate)
      timeIntervalSinceReferenceDate - x.timeIntervalSinceReferenceDate
    else
      unless x.is_a?(Numeric)
        if x && x.respond_to?(:to_r)
          x = x.to_r # TODO: maybe we should skip this
        else
          raise TypeError
        end
      end
      self.class.dateWithTimeIntervalSinceReferenceDate(timeIntervalSinceReferenceDate - x.to_f)
    end
  end
  
  # call-seq:
  #    time + numeric => time
  # 
  # Addition---Adds some number of seconds (possibly fractional) to
  # <i>time</i> and returns that value as a new time.
  #    
  #    t = Time.now         #=> 2007-11-19 08:22:21 -0600
  #    t + (60 * 60 * 24)   #=> 2007-11-20 08:22:21 -0600
  def +(x)
    unless x.is_a?(Numeric)
      if x && x.respond_to?(:to_r)
        x = x.to_r # TODO: maybe we should skip this
      else
        raise TypeError
      end
    end
    self.class.dateWithTimeIntervalSinceReferenceDate(timeIntervalSinceReferenceDate + x.to_f)
  end
  
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
  
  # call-seq:
  #    time.yday => fixnum
  # 
  # Returns an integer representing the day of the year, 1..366.
  #    
  #    t = Time.now   #=> 2007-11-19 08:32:31 -0600
  #    t.yday         #=> 323
  def yday
    calendar.ordinalityOfUnit(NSDayCalendarUnit, inUnit: NSYearCalendarUnit, forDate: self)
  end
  
  def hour
    components.hour
  end
  
  def min
    components.minute
  end
  alias_method :minute, :min
  
  def sec
    components.second
  end
  alias_method :second, :sec
  
  def usec
    interval = timeIntervalSince1970
    decimals = interval - interval.to_i
    (decimals * 1_000_000).round
  end
  alias_method :tv_usec, :usec
  
  def to_i
    timeIntervalSince1970.round
  end
  alias_method :tv_sec, :to_i
  
  def to_f
    timeIntervalSince1970
  end
  
  # call-seq:
  #   time.succ   => new_time
  # 
  # Return a new time object, one second later than <code>time</code>.
  # 
  #     t = Time.now       #=> 2007-11-19 08:23:57 -0600
  #     t.succ             #=> 2007-11-19 08:23:58 -0600
  def succ
    self.class.dateWithTimeIntervalSinceReferenceDate(timeIntervalSinceReferenceDate + 1)
  end
  
  ##
  #
  # Specific day sugar
  #
  
  # call-seq:
  #    time.sunday? => true or false
  # 
  # Returns <code>true</code> if <i>time</i> represents Sunday.
  #    
  #    t = Time.local(1990, 4, 1)       #=> 1990-04-01 00:00:00 -0600
  #    t.sunday?                        #=> true
  def sunday?
    wday == 0
  end
  
  # call-seq:
  #    time.monday? => true or false
  # 
  # Returns <code>true</code> if <i>time</i> represents Monday.
  # 
  #    t = Time.local(2003, 8, 4)       #=> 2003-08-04 00:00:00 -0500
  #    p t.monday?                      #=> true
  def monday?
    wday == 1
  end
  
  # call-seq:
  #    time.tuesday? => true or false
  # 
  # Returns <code>true</code> if <i>time</i> represents Tuesday.
  # 
  #    t = Time.local(1991, 2, 19)      #=> 1991-02-19 00:00:00 -0600
  #    p t.tuesday?                     #=> true
  def tuesday?
    wday == 2
  end
  
  # call-seq:
  #    time.wednesday? => true or false
  # 
  # Returns <code>true</code> if <i>time</i> represents Wednesday.
  # 
  #    t = Time.local(1993, 2, 24)      #=> 1993-02-24 00:00:00 -0600
  #    p t.wednesday?                   #=> true
  def wednesday?
    wday == 3
  end
  
  # call-seq:
  #    time.thursday? => true or false
  # 
  # Returns <code>true</code> if <i>time</i> represents Thursday.
  # 
  #    t = Time.local(1995, 12, 21)     #=> 1995-12-21 00:00:00 -0600
  #    p t.thursday?                    #=> true
  def thursday?
    wday == 4
  end
  
  # call-seq:
  #    time.friday? => true or false
  # 
  # Returns <code>true</code> if <i>time</i> represents Friday.
  # 
  #    t = Time.local(1987, 12, 18)     #=> 1987-12-18 00:00:00 -0600
  #    t.friday?                        #=> true
  def friday?
    wday == 5
  end
  
  # call-seq:
  #    time.saturday? => true or false
  # 
  # Returns <code>true</code> if <i>time</i> represents Saturday.
  # 
  #    t = Time.local(2006, 6, 10)      #=> 2006-06-10 00:00:00 -0500
  #    t.saturday?                      #=> true
  def saturday?
    wday == 6
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
  
  # asserts x is a numeric and assigns it to the method type, eg year, month, day
  def date_with_offset(x, type)
    raise TypeError, "expected numeric" unless x.is_a?(Numeric)
    
    offset = NSDateComponents.new
    offset.send("#{type}=", x)
    calendar.dateByAddingComponents(offset, toDate: self, options: 0)
  end
end

class NSDate
  include MRTimeAPI
end