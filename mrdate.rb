framework 'Foundation'

class MRDate < NSDate
  JULIAN_DAY_FORMATTER = NSDateFormatter.new
  JULIAN_DAY_FORMATTER.dateFormat = "g"
  
  GREGORIAN_CALENDAR = NSCalendar.alloc.initWithCalendarIdentifier(NSGregorianCalendar)
  PARSE_COMPONENTS = NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit
  
  BC = 0
  AD = 1
  
  ##
  #
  # original date.rb constants:
  #
  
  # The Julian Day Number of the Day of Calendar Reform for Italy
  # and the Catholic countries.
  # ITALY = 2299161 # 1582-10-15
  ITALY = JULIAN_DAY_FORMATTER.dateFromString("2299161").timeIntervalSinceReferenceDate # 1582-10-15
  
  # The Julian Day Number of the Day of Calendar Reform for England
  # and her Colonies.
  # ENGLAND   = 2361222 # 1752-09-14
  
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
  
  def self.new(year = -4712, month = 1, day = 1, sg = ITALY)
    # p year, month, day
    
    components = NSDateComponents.new
    components.year = year
    components.month = month
    components.day = day
    
    interval = GREGORIAN_CALENDAR.dateFromComponents(components).timeIntervalSinceReferenceDate
    date = alloc.initWithTimeIntervalSinceReferenceDate(interval)
    date.sg = sg
    date
  end
  
  attr_accessor :sg
  
  def year
    components.era == BC ? -(components.year - 1) : components.year
  end
  
  def month
    components.month
  end
  
  def day
    components.day
  end
  
  # TODO: lazy bastard
  def jd
    JULIAN_DAY_FORMATTER.stringFromDate(self).to_i
  end
  
  def julian?
    timeIntervalSinceReferenceDate < @sg
  end
  
  private
  
  def components
    GREGORIAN_CALENDAR.components(PARSE_COMPONENTS, fromDate: self)
  end
end