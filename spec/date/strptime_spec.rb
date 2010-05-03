require File.expand_path('../../spec_helper', __FILE__)

describe "MRDate#strptime" do

  it "returns January 1, 4713 BCE when given no arguments" do
    MRDate.strptime.should == MRDate.civil(-4712, 1, 1)
  end

  it "uses the default format when not given a date format" do
    MRDate.strptime("2000-04-06").should == MRDate.civil(2000, 4, 6)
    MRDate.civil(2000, 4, 6).strftime.should == MRDate.civil(2000, 4, 6).to_s
  end

  it "parses a full day name" do
    d = MRDate.today
    expected_date = MRDate.commercial(d.cwyear, d.cweek, 4)
    # strptime assumed week that start on sunday, not monday
    expected_date += 7 if d.cwday == 7
    MRDate.strptime("Thursday", "%A").should == expected_date
  end

  it "parses a short day name" do
    d = MRDate.today
    expected_date = MRDate.commercial(d.cwyear, d.cweek, 4)
    # strptime assumed week that start on sunday, not monday
    expected_date += 7 if d.cwday == 7
    MRDate.strptime("Thu", "%a").should == expected_date
  end

  it "parses a full month name" do
    d = MRDate.today
    MRDate.strptime("April", "%B").should == MRDate.civil(d.year, 4, 1)
  end

  it "parses a short month name" do
    d = MRDate.today
    MRDate.strptime("Apr", "%b").should == MRDate.civil(d.year, 4, 1)
    MRDate.strptime("Apr", "%h").should == MRDate.civil(d.year, 4, 1)
  end

  it "parses a century" do
    MRDate.strptime("06 20", "%y %C").should == MRDate.civil(2006, 1, 1)
  end

  it "parses a month day with leading zeroes" do
    d = MRDate.today
    MRDate.strptime("06", "%d").should == MRDate.civil(d.year, d.month, 6)
  end

  it "parses a month day with leading spaces" do
    d = MRDate.today
    MRDate.strptime(" 6", "%e").should == MRDate.civil(d.year, d.month, 6)
  end

  it "parses a commercial year with leading zeroes" do
    MRDate.strptime("2000", "%G").should == MRDate.civil(2000,  1,  3)
    MRDate.strptime("2002", "%G").should == MRDate.civil(2001, 12, 31)
  end

  it "parses a commercial year with only two digits" do
    MRDate.strptime("68", "%g").should == MRDate.civil(2068,  1,  2)
    MRDate.strptime("69", "%g").should == MRDate.civil(1968, 12, 30)
  end

  it "parses a year day with leading zeroes" do
    d = MRDate.today
    if MRDate.gregorian_leap?(MRDate.today.year)
      MRDate.strptime("097", "%j").should == MRDate.civil(d.year, 4, 6)
    else
      MRDate.strptime("097", "%j").should == MRDate.civil(d.year, 4, 7)
    end
  end

  it "parses a month with leading zeroes" do
    d = MRDate.today
    MRDate.strptime("04", "%m").should == MRDate.civil(d.year, 4, 1)
  end

  it "parses a week number for a week starting on Sunday" do
    MRDate.strptime("2010/1", "%Y/%U").should == MRDate.civil(2010, 1, 3)
  end

  # See http://redmine.ruby-lang.org/repositories/diff/ruby-19?rev=24500
  ruby_bug "http://redmine.ruby-lang.org/issues/show/2556", "1.8" do
    it "parses a week number for a week starting on Monday" do
      MRDate.strptime("2010/1", "%Y/%W").should == MRDate.civil(2010, 1, 4)
    end
  end

  it "parses a commercial week day" do
    MRDate.strptime("2008 1", "%G %u").should == MRDate.civil(2007, 12, 31)
  end

  it "parses a commercial week" do
    d = MRDate.commercial(MRDate.today.cwyear,1,1)
    MRDate.strptime("1", "%V").should == d
    MRDate.strptime("15", "%V").should == MRDate.commercial(d.cwyear, 15, 1)
  end

  it "parses a week day" do
    d = MRDate.today
    MRDate.strptime("2007 4", "%Y %w").should == MRDate.civil(2007, 1, 4)
  end

  it "parses a year in YYYY format" do
    MRDate.strptime("2007", "%Y").should == MRDate.civil(2007, 1, 1)
  end

  it "parses a year in YY format" do
    MRDate.strptime("00", "%y").should == MRDate.civil(2000, 1, 1)
  end

  ############################
  # Specs that combine stuff #
  ############################

  it "parses a full date" do
    MRDate.strptime("Thu Apr  6 00:00:00 2000", "%c").should == MRDate.civil(2000, 4, 6)
    MRDate.strptime("Thu Apr  6 00:00:00 2000", "%a %b %e %H:%M:%S %Y").should == MRDate.civil(2000, 4, 6)
  end

  it "parses a date with slashes" do
    MRDate.strptime("04/06/00", "%D").should == MRDate.civil(2000, 4, 6)
    MRDate.strptime("04/06/00", "%m/%d/%y").should == MRDate.civil(2000, 4, 6)
  end

  it "parses a date given as YYYY-MM-DD" do
    MRDate.strptime("2000-04-06", "%F").should == MRDate.civil(2000, 4, 6)
    MRDate.strptime("2000-04-06", "%Y-%m-%d").should == MRDate.civil(2000, 4, 6)
  end

  it "parses a commercial week" do
    MRDate.strptime(" 9-Apr-2000", "%v").should == MRDate.civil(2000, 4, 9)
    MRDate.strptime(" 9-Apr-2000", "%e-%b-%Y").should == MRDate.civil(2000, 4, 9)
  end
  
  it "parses a date given MM/DD/YY" do
    MRDate.strptime("04/06/00", "%x").should == MRDate.civil(2000, 4, 6)
    MRDate.strptime("04/06/00", "%m/%d/%y").should == MRDate.civil(2000, 4, 6)
  end
  
  it "parses a date given in full notation" do
    MRDate.strptime("Sun Apr  9 00:00:00 +00:00 2000", "%+").should == MRDate.civil(2000, 4, 9)
    MRDate.strptime("Sun Apr  9 00:00:00 +00:00 2000", "%a %b %e %H:%M:%S %Z %Y").should == MRDate.civil(2000, 4, 9)
  end

end
