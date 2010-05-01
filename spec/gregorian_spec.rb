require 'date' 
require File.expand_path('../../../spec_helper', __FILE__)

describe "MRDate#gregorian?" do

  it "should mark a day before the calendar reform as Julian" do
    MRDate.civil(1007, 2, 27).gregorian?.should == false
    MRDate.civil(1907, 2, 27, MRDate.civil(2000, 1, 1).jd).gregorian?.should == false
  end
  
  it "should mark a day after the calendar reform as Julian" do
    MRDate.civil(2007, 2, 27).gregorian?.should == true
    MRDate.civil(1007, 2, 27, MRDate.civil(1000, 1, 1).jd).gregorian?.should == true
  end
  
end

describe "MRDate#gregorian_leap?" do

  it "should be able to determine whether a year is a leap year in the Gregorian calendar" do
    MRDate.gregorian_leap?(1900).should == false
    MRDate.gregorian_leap?(1999).should == false
    MRDate.gregorian_leap?(2000).should == true
    MRDate.gregorian_leap?(2002).should == false
    MRDate.gregorian_leap?(2004).should == true
  end

end