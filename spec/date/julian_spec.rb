require File.expand_path('../../spec_helper', __FILE__)

describe "MRDate#jd" do

  it "should be able to construct a MRDate object based on the Julian day" do
    MRDate.jd(2454482).should == MRDate.civil(2008, 1, 16)
  end

  it "should be able to determine the Julian day for a MRDate object" do
    MRDate.civil(2008, 1, 16).jd.should == 2454482
  end
  
end

describe "MRDate#julian?" do

  it "should mark a day before the calendar reform as Julian" do
    MRDate.civil(1007, 2, 27).julian?.should == true
    MRDate.civil(1907, 2, 27, MRDate.civil(2000, 1, 1).jd).julian?.should == true
  end
  
  it "should mark a day after the calendar reform as Julian" do
    MRDate.civil(2007, 2, 27).julian?.should == false
    MRDate.civil(1007, 2, 27, MRDate.civil(1000, 1, 1).jd).julian?.should == false
  end
  
end

describe "MRDate#julian_leap?" do

  it "should be able to determine whether a year is a leap year in the Julian calendar" do
    MRDate.julian_leap?(1900).should == true
    MRDate.julian_leap?(1999).should == false
    MRDate.julian_leap?(2000).should == true
    MRDate.julian_leap?(2002).should == false
    MRDate.julian_leap?(2004).should == true
  end

end

ruby_version_is "" ... "1.9" do
  describe "MRDate#valid_jd?" do

    it "should be able to determine if a day number is a valid Julian day number, true for all numbers" do
      # This might need to check the type of the jd parameter. MRDate.valid_jd?(:number) is of course
      # bogus but returns itself with the current implementation
      MRDate.valid_jd?(-100).should == -100
      MRDate.valid_jd?(0).should    ==    0
      MRDate.valid_jd?(100).should  ==  100
    end

  end
end

ruby_version_is "1.9" do
  describe "MRDate#valid_jd?" do

    it "should be able to determine if a day number is a valid Julian day number, true for all numbers" do
      # This might need to check the type of the jd parameter. MRDate.valid_jd?(:number) is of course
      # bogus but returns itself with the current implementation
      MRDate.valid_jd?(-100).should == true
      MRDate.valid_jd?(0).should    == true
      MRDate.valid_jd?(100).should  == true
    end

  end
end