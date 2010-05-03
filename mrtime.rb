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
  
  def self.new
    date
  end
  
  def to_i
    timeIntervalSince1970.round
  end
end
