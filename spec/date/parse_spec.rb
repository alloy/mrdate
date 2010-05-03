require File.expand_path('../../spec_helper', __FILE__)
require File.expand_path('../shared/parse', __FILE__)
require File.expand_path('../shared/parse_us', __FILE__)
require File.expand_path('../shared/parse_eu', __FILE__)

describe "MRDate#parse" do
  # The space separator is also different, doesn't work for only numbers
  it "can parse a day name into a MRDate object" do
    d = MRDate.parse("friday")
    d.should == MRDate.commercial(d.cwyear, d.cweek, 5)
  end

  it "can parse a month name into a MRDate object" do
    d = MRDate.parse("october")
    d.should == MRDate.civil(MRDate.today.year, 10)
  end

  it "can parse a month day into a MRDate object" do
    d = MRDate.parse("5th")
    d.should == MRDate.civil(MRDate.today.year, MRDate.today.month, 5)
  end

  # Specs using numbers
  it "can't handle a single digit" do
    lambda{ MRDate.parse("1") }.should raise_error(ArgumentError)
  end

  it "can handle DD as month day number" do
    d = MRDate.parse("10")
    d.should == MRDate.civil(MRDate.today.year, MRDate.today.month, 10)
  end

  it "can handle DDD as year day number" do
    d = MRDate.parse("100")
    if MRDate.gregorian_leap?(MRDate.today.year)
      d.should == MRDate.civil(MRDate.today.year, 4, 9)
    else
      d.should == MRDate.civil(MRDate.today.year, 4, 10)
    end
  end

  it "can handle MMDD as month and day" do
    d = MRDate.parse("1108")
    d.should == MRDate.civil(MRDate.today.year, 11, 8)
  end

  ruby_version_is "" ... "1.9" do
    it "can handle YYDDD as year and day number" do
      d = MRDate.parse("10100")
      d.should == MRDate.civil(10, 4, 10)
    end

    it "can handle YYMMDD as year month and day" do
      d = MRDate.parse("201023")
      d.should == MRDate.civil(20, 10, 23)
    end
  end

  ruby_version_is "1.9" do
    it "can handle YYDDD as year and day number in 1969--2068" do
      d = MRDate.parse("10100")
      d.should == MRDate.civil(2010, 4, 10)
    end

    it "can handle YYMMDD as year month and day in 1969--2068" do
      d = MRDate.parse("201023")
      d.should == MRDate.civil(2020, 10, 23)
    end
  end

  it "can handle YYYYDDD as year and day number" do
    d = MRDate.parse("1910100")
    d.should == MRDate.civil(1910, 4, 10)
  end

  it "can handle YYYYMMDD as year and day number" do
    d = MRDate.parse("19101101")
    d.should == MRDate.civil(1910, 11, 1)
  end
end

describe "MRDate#parse with '.' separator" do
  before :all do
    @sep = '.'
  end

  it_should_behave_like "date_parse"
end

describe "MRDate#parse with '/' separator" do
  before :all do
    @sep = '/'
  end

  it_should_behave_like "date_parse"
end

describe "MRDate#parse with ' ' separator" do
  before :all do
    @sep = ' '
  end

  it_should_behave_like "date_parse"
end

describe "MRDate#parse with '/' separator US-style" do
  before :all do
    @sep = '/'
  end

  it_should_behave_like "date_parse_us"
end

ruby_version_is "" ... "1.8.7" do
  describe "MRDate#parse with '.' separator US-style" do
    before :all do
      @sep = '.'
    end

    it_should_behave_like "date_parse_us"
  end
end

describe "MRDate#parse with '-' separator EU-style" do
  before :all do
    @sep = '-'
  end

  it_should_behave_like "date_parse_eu"
end

ruby_version_is "1.8.7" do
  describe "MRDate#parse(.)" do
    it "parses a YYYY.MM.DD string into a MRDate object" do
      d = MRDate.parse("2007.10.01")
      d.year.should  == 2007
      d.month.should == 10
      d.day.should   == 1
    end

    it "parses a DD.MM.YYYY string into a MRDate object" do
      d = MRDate.parse("10.01.2007")
      d.year.should  == 2007
      d.month.should == 1
      d.day.should   == 10
    end

    ruby_version_is "" ... "1.9" do
      it "parses a YY.MM.DD string into a MRDate object" do
	d = MRDate.parse("10.01.07")
	d.year.should  == 10
	d.month.should == 1
	d.day.should   == 7
      end
    end

    ruby_version_is "1.9" do
      it "parses a YY.MM.DD string into a MRDate object" do
	d = MRDate.parse("10.01.07")
	d.year.should  == 2010
	d.month.should == 1
	d.day.should   == 7
      end
    end

    it "parses a YY.MM.DD string into a MRDate object using the year digits as 20XX" do
      d = MRDate.parse("10.01.07", true)
      d.year.should  == 2010
      d.month.should == 1
      d.day.should   == 7
    end
  end
end
