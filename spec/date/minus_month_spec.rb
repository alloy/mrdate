require File.expand_path('../../spec_helper', __FILE__)

describe "MRDate#<<" do

  it "should substract a number of months from a date" do
    d = MRDate.civil(2007,2,27) << 10
    d.should == MRDate.civil(2006, 4, 27)
  end

  it "should result in the last day of a month if the day doesn't exist" do
    d = MRDate.civil(2008,3,31) << 1
    d.should == MRDate.civil(2008, 2, 29)
  end

  it "should raise an error on non numeric parameters" do
    lambda { MRDate.civil(2007,2,27) << :hello }.should raise_error(NoMethodError)
    lambda { MRDate.civil(2007,2,27) << "hello" }.should raise_error(NoMethodError)
    lambda { MRDate.civil(2007,2,27) << MRDate.new }.should raise_error(NoMethodError)
    lambda { MRDate.civil(2007,2,27) << Object.new }.should raise_error(NoMethodError)
  end
  
end