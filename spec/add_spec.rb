require 'date' 
require File.expand_path('../../../spec_helper', __FILE__)

describe "MRDate#+" do

  it "should add a number of days to a MRDate" do
    d = MRDate.civil(2007,2,27) + 10
    d.should == MRDate.civil(2007, 3, 9)
  end
  
  it "should add a negative number of days to a MRDate" do
    d = MRDate.civil(2007,2,27).+(-10)
    d.should == MRDate.civil(2007, 2, 17)
  end

  it "should raise an error on non numeric parameters" do
    lambda { MRDate.civil(2007,2,27) + :hello }.should raise_error(TypeError)
    lambda { MRDate.civil(2007,2,27) + "hello" }.should raise_error(TypeError)
    lambda { MRDate.civil(2007,2,27) + MRDate.new }.should raise_error(TypeError)
    lambda { MRDate.civil(2007,2,27) + Object.new }.should raise_error(TypeError)
  end
  
end