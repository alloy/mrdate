require File.expand_path('../../spec_helper', __FILE__)
require File.expand_path('../fixtures/methods', __FILE__)

describe "MRTime#strftime" do
  it "formats time according to the directives in the given format string" do
    with_timezone("GMT", 0) do
      MRTime.at(0).strftime("There is %M minutes in epoch").should == "There is 00 minutes in epoch"
    end
  end

  it "supports week of year format with %U and %W" do
    # start of the yer
    saturday_first = MRTime.local(2000,1,1,14,58,42)
    saturday_first.strftime("%U").should == "00"
    saturday_first.strftime("%W").should == "00"

    sunday_second = MRTime.local(2000,1,2,14,58,42)
    sunday_second.strftime("%U").should == "01"
    sunday_second.strftime("%W").should == "00"

    monday_third = MRTime.local(2000,1,3,14,58,42)
    monday_third.strftime("%U").should == "01"
    monday_third.strftime("%W").should == "01"

    sunday_9th = MRTime.local(2000,1,9,14,58,42)
    sunday_9th.strftime("%U").should == "02"
    sunday_9th.strftime("%W").should == "01"

    monday_10th = MRTime.local(2000,1,10,14,58,42)
    monday_10th.strftime("%U").should == "02"
    monday_10th.strftime("%W").should == "02"

    # middle of the year
    some_sunday = MRTime.local(2000,8,6,4,20,00)
    some_sunday.strftime("%U").should == "32"
    some_sunday.strftime("%W").should == "31"
    some_monday = MRTime.local(2000,8,7,4,20,00)
    some_monday.strftime("%U").should == "32"
    some_monday.strftime("%W").should == "32"

    # end of year, and start of next one
    saturday_30th = MRTime.local(2000,12,30,14,58,42)
    saturday_30th.strftime("%U").should == "52"
    saturday_30th.strftime("%W").should == "52"

    sunday_last = MRTime.local(2000,12,31,14,58,42)
    sunday_last.strftime("%U").should == "53"
    sunday_last.strftime("%W").should == "52"

    monday_first = MRTime.local(2001,1,1,14,58,42)
    monday_first.strftime("%U").should == "00"
    monday_first.strftime("%W").should == "01"
  end

  it "supports mm/dd/yy formatting with %D" do
    now = MRTime.now
    mmddyy = now.strftime('%m/%d/%y')
    now.strftime('%D').should == mmddyy
  end

  it "supports HH:MM:SS formatting with %T" do
    now = MRTime.now
    hhmmss = now.strftime('%H:%M:%S')
    now.strftime('%T').should == hhmmss
  end

  it "supports timezone formatting with %z" do
    with_timezone("UTC", 0) do
      time = MRTime.utc(2005, 2, 21, 17, 44, 30)
      time.strftime("%z").should == "+0000"
    end
  end

  it "supports 12-hr formatting with %l" do
    time = MRTime.local(2004, 8, 26, 22, 38, 3)
    time.strftime('%l').should == '10'
    morning_time = MRTime.local(2004, 8, 26, 6, 38, 3)
    morning_time.strftime('%l').should == ' 6'
  end

  it "supports AM/PM formatting with %p" do
    time = MRTime.local(2004, 8, 26, 22, 38, 3)
    time.strftime('%p').should == 'PM'
    time = MRTime.local(2004, 8, 26, 11, 38, 3)
    time.strftime('%p').should == 'AM'
  end
  
  it "returns the abbreviated weekday with %a" do
    time = MRTime.local(2009, 9, 18, 12, 0, 0)
    time.strftime('%a').should == 'Fri'
  end
  
  it "returns the full weekday with %A" do
    time = MRTime.local(2009, 9, 18, 12, 0, 0)
    time.strftime('%A').should == 'Friday'
  end
  
  it "returns the abbreviated month with %b" do
    time = MRTime.local(2009, 9, 18, 12, 0, 0)
    time.strftime('%b').should == 'Sep'
  end
  
  it "returns the full month with %B" do
    time = MRTime.local(2009, 9, 18, 12, 0, 0)
    time.strftime('%B').should == 'September'
  end
  
  it "returns the day of the month with %d" do
    time = MRTime.local(2009, 9, 18, 12, 0, 0)
    time.strftime('%d').should == '18'
  end
  
  it "returns the 24-based hour with %H" do
    time = MRTime.local(2009, 9, 18, 18, 0, 0)
    time.strftime('%H').should == '18'
  end
  
  it "returns the 12-based hour with %I" do
    time = MRTime.local(2009, 9, 18, 18, 0, 0)
    time.strftime('%I').should == '06'
  end
  
  it "returns the Julian date with %j" do
    time = MRTime.local(2009, 9, 18, 18, 0, 0)
    time.strftime('%j').should == '261'
  end
  
  it "returns the month with %m" do
    time = MRTime.local(2009, 9, 18, 12, 0, 0)
    time.strftime('%m').should == '09'
  end
  
  it "returns the minute with %M" do
    time = MRTime.local(2009, 9, 18, 12, 6, 0)
    time.strftime('%M').should == '06'
  end
  
  it "returns the second with %S" do
    time = MRTime.local(2009, 9, 18, 12, 0, 6)
    time.strftime('%S').should == '06'
  end
  
  it "returns the enumerated day of the week with %w" do
    time = MRTime.local(2009, 9, 18, 12, 0, 0)
    time.strftime('%w').should == '5'
  end
  
  it "returns the year wihout a century with %y" do
    time = MRTime.local(2009, 9, 18, 12, 0, 0)
    time.strftime('%y').should == '09'
  end
  
  it "returns the year with %Y" do
    time = MRTime.local(2009, 9, 18, 12, 0, 0)
    time.strftime('%Y').should == '2009'
  end  

  not_compliant_on :macruby do
    it "supports GNU modificators" do
      time = MRTime.local(2001, 2, 3, 4, 5, 6)

      time.strftime('%^h').should == 'FEB'
      time.strftime('%^_5h').should == '  FEB'
      time.strftime('%0^5h').should == '00FEB'
      time.strftime('%04H').should == '0004'
      time.strftime('%0-^5h').should == 'FEB'
      time.strftime('%_-^5h').should == 'FEB'
      time.strftime('%^ha').should == 'FEBa'

      expected = {
        "%10h" => '       Feb',
        "%^10h" => '       FEB',
        "%_10h" => '       Feb',
        "%_010h" => '0000000Feb',
        "%0_10h" => '       Feb',
        "%0_-10h" => 'Feb',
        "%0-_10h" => 'Feb'
      }

      ["%10h","%^10h","%_10h","%_010h","%0_10h","%0_-10h","%0-_10h"].each do |format|
        time.strftime(format).should == expected[format]
      end
    end
  end
end
