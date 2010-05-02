require File.expand_path('../spec_helper', __FILE__)

describe "MRDate#strftime" do

  # it "should be able to print the date" do
  #   MRDate.civil(2000, 4, 6).strftime.should == "2000-04-06"
  #   MRDate.civil(2000, 4, 6).strftime.should == MRDate.civil(2000, 4, 6).to_s
  # end

  it "should be able to print the full day name" do
    MRDate.civil(2000, 4, 6).strftime("%A").should == "Thursday"
  end
  
  it "should be able to print the short day name" do
    MRDate.civil(2000, 4, 6).strftime("%a").should == "Thu"
  end
  
  it "should be able to print the full month name" do
    MRDate.civil(2000, 4, 6).strftime("%B").should == "April"
  end
  
  it "should be able to print the short month name" do
    MRDate.civil(2000, 4, 6).strftime("%b").should == "Apr"
    # MRDate.civil(2000, 4, 6).strftime("%h").should == "Apr"
    # MRDate.civil(2000, 4, 6).strftime("%b").should == MRDate.civil(2000, 4, 6).strftime("%h")
  end
  
  # it "should be able to print the century" do
  #   MRDate.civil(2000, 4, 6).strftime("%C").should == "20"
  # end
  
  it "should be able to print the month day with leading zeroes" do
    MRDate.civil(2000, 4, 6).strftime("%d").should == "06"
  end
  
  # it "should be able to print the month day with leading spaces" do
  #   MRDate.civil(2000, 4, 6).strftime("%e").should == " 6"
  # end
  
  # it "should be able to print the commercial year with leading zeroes" do
  #   MRDate.civil(2000, 4, 6).strftime("%G").should == "2000"
  #   MRDate.civil( 200, 4, 6).strftime("%G").should == "0200"
  # end
  
  # it "should be able to print the commercial year with only two digits" do
  #   MRDate.civil(2000, 4, 6).strftime("%g").should == "00"
  #   MRDate.civil( 200, 4, 6).strftime("%g").should == "00"
  # end
  
  it "should be able to print the hour with leading zeroes (hour is always 00)" do
    MRDate.civil(2000, 4, 6).strftime("%H").should == "00"
  end
  
  it "should be able to print the hour in 12 hour notation with leading zeroes" do
    MRDate.civil(2000, 4, 6).strftime("%I").should == "12"
  end
  
  it "should be able to print the year day with leading zeroes" do
    MRDate.civil(2000, 4, 6).strftime("%j").should == "097"
  end
  
  # it "should be able to print the hour in 24 hour notation with leading spaces" do
  #   MRDate.civil(2000, 4, 6).strftime("%k").should == " 0"
  # end
  
  # it "should be able to print the hour in 12 hour notation with leading spaces" do
  #   MRDate.civil(2000, 4, 6).strftime("%l").should == "12"
  # end
  
  it "should be able to print the minutes with leading zeroes" do
    MRDate.civil(2000, 4, 6).strftime("%M").should == "00"
  end
  
  it "should be able to print the month with leading zeroes" do
    MRDate.civil(2000, 4, 6).strftime("%m").should == "04"
  end
  
  # it "should be able to add a newline" do
  #   MRDate.civil(2000, 4, 6).strftime("%n").should == "\n"
  # end
  
  # it "should be able to show AM/PM" do
  #   MRDate.civil(2000, 4, 6).strftime("%P").should == "am"
  # end
  
  it "should be able to show am/pm" do
    MRDate.civil(2000, 4, 6).strftime("%p").should == "AM"
  end
  
  it "should be able to show the number of seconds with leading zeroes" do
    MRDate.civil(2000, 4, 6).strftime("%S").should == "00"
  end
  
  it "should be able to show the number of seconds with leading zeroes" do
    MRDate.civil(2000, 4, 6).strftime("%S").should == "00"
  end
  
  # it "should be able to show the number of seconds since the unix epoch" do
  #   MRDate.civil(2000, 4, 6).strftime("%s").should == "954979200"
  # end
  
  # it "should be able to add a tab" do
  #   MRDate.civil(2000, 4, 6).strftime("%t").should == "\t"
  # end
  
  # it "should be able to show the week number with the week starting on sunday and monday" do
  #   MRDate.civil(2000, 4, 6).strftime("%U").should == "14"
  #   MRDate.civil(2000, 4, 6).strftime("%W").should == "14"
  #   MRDate.civil(2000, 4, 6).strftime("%U").should == MRDate.civil(2000, 4, 6).strftime("%W")
  #   MRDate.civil(2000, 4, 9).strftime("%U").should == "15"
  #   MRDate.civil(2000, 4, 9).strftime("%W").should == "14"
  #   MRDate.civil(2000, 4, 9).strftime("%U").should_not == MRDate.civil(2000, 4, 9).strftime("%W")
  # end
  
  # it "should be able to show the commercial week day" do
  #   MRDate.civil(2000, 4,  9).strftime("%u").should == "7"
  #   MRDate.civil(2000, 4, 10).strftime("%u").should == "1"
  # end
  
  # it "should be able to show the commercial week" do
  #   MRDate.civil(2000, 4,  9).strftime("%V").should == "14"
  #   MRDate.civil(2000, 4, 10).strftime("%V").should == "15"
  # end
  
  it "should be able to show the week day" do
    MRDate.civil(2000, 4,  9).strftime("%w").should == "0"
    MRDate.civil(2000, 4, 10).strftime("%w").should == "1"
  end
  
  it "should be able to show the year in YYYY format" do
    MRDate.civil(2000, 4,  9).strftime("%Y").should == "2000"
  end
  
  it "should be able to show the year in YY format" do
    MRDate.civil(2000, 4,  9).strftime("%y").should == "00"
  end
  
  # TODO: Returns TZ name
  # it "should be able to show the timezone of the date with a : separator" do
  #   MRDate.civil(2000, 4,  9).strftime("%Z").should == "+00:00"
  # end
  
  # TODO: Uses the current users local TZ
  # it "should be able to show the timezone of the date with a : separator" do
  #   MRDate.civil(2000, 4,  9).strftime("%z").should == "+0000"
  # end
  
  it "should be able to escape the % character" do
    MRDate.civil(2000, 4,  9).strftime("%%").should == "%"
  end
  
  ############################
  # Specs that combine stuff #
  ############################
  
  # it "should be able to print the date in full" do
  #   MRDate.civil(2000, 4, 6).strftime("%c").should == "Thu Apr  6 00:00:00 2000"
  #   MRDate.civil(2000, 4, 6).strftime("%c").should == MRDate.civil(2000, 4, 6).strftime('%a %b %e %H:%M:%S %Y')
  # end
  
  # it "should be able to print the date with slashes" do
  #   MRDate.civil(2000, 4, 6).strftime("%D").should == "04/06/00"
  #   MRDate.civil(2000, 4, 6).strftime("%D").should == MRDate.civil(2000, 4, 6).strftime('%m/%d/%y')  
  # end
  
  # it "should be able to print the date as YYYY-MM-DD" do
  #   MRDate.civil(2000, 4, 6).strftime("%F").should == "2000-04-06"
  #   MRDate.civil(2000, 4, 6).strftime("%F").should == MRDate.civil(2000, 4, 6).strftime('%Y-%m-%d')
  # end
  
  # it "should be able to show HH:MM" do
  #   MRDate.civil(2000, 4, 6).strftime("%R").should == "00:00"
  #   MRDate.civil(2000, 4, 6).strftime("%R").should == MRDate.civil(2000, 4, 6).strftime('%H:%M')
  # end
  
  # it "should be able to show HH:MM:SS AM/PM" do
  #   MRDate.civil(2000, 4, 6).strftime("%r").should == "12:00:00 AM"
  #   MRDate.civil(2000, 4, 6).strftime("%r").should == MRDate.civil(2000, 4, 6).strftime('%I:%M:%S %p')
  # end
  
  # it "should be able to show HH:MM:SS" do
  #   MRDate.civil(2000, 4, 6).strftime("%T").should == "00:00:00"
  #   MRDate.civil(2000, 4, 6).strftime("%T").should == MRDate.civil(2000, 4, 6).strftime('%H:%M:%S')
  # end
  
  # it "should be able to show the commercial week" do
  #   MRDate.civil(2000, 4,  9).strftime("%v").should == " 9-Apr-2000"
  #   MRDate.civil(2000, 4,  9).strftime("%v").should == MRDate.civil(2000, 4,  9).strftime('%e-%b-%Y')
  # end
  
  # TODO: adds TZ name
  # it "should be able to show HH:MM:SS" do
  #   MRDate.civil(2000, 4, 6).strftime("%X").should == "00:00:00"
  #   MRDate.civil(2000, 4, 6).strftime("%X").should == MRDate.civil(2000, 4, 6).strftime('%H:%M:%S')
  # end
  
  # it "should be able to show MM/DD/YY" do
  #   MRDate.civil(2000, 4, 6).strftime("%x").should == "04/06/00"
  #   MRDate.civil(2000, 4, 6).strftime("%x").should == MRDate.civil(2000, 4, 6).strftime('%m/%d/%y')
  # end
  
  # it "should be able to show a full notation" do
  #   MRDate.civil(2000, 4,  9).strftime("%+").should == "Sun Apr  9 00:00:00 +00:00 2000"
  #   MRDate.civil(2000, 4,  9).strftime("%+").should == MRDate.civil(2000, 4,  9).strftime('%a %b %e %H:%M:%S %Z %Y')
  # end

end