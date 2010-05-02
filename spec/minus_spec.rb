require File.expand_path('../spec_helper', __FILE__)

describe "MRDate#-" do

  it "should substract a number of days from a MRDate" do
    d = MRDate.civil(2007, 5 ,2) - 13
    d.should == MRDate.civil(2007, 4, 19)
  end
  
  it "should substract a negative number of days from a MRDate" do
    d = MRDate.civil(2007, 4, 19).-(-13)
    d.should == MRDate.civil(2007, 5 ,2)
  end
  
  it "should be able to compute the different between two dates" do
    (MRDate.civil(2007,2,27) - MRDate.civil(2007,2,27)).should == 0
    (MRDate.civil(2007,2,27) - MRDate.civil(2007,2,26)).should == 1
    (MRDate.civil(2006,2,27) - MRDate.civil(2007,2,27)).should == -365
    (MRDate.civil(2008,2,27) - MRDate.civil(2007,2,27)).should == 365
    
  end
  
  it "should raise an error on non numeric parameters" do
    lambda { MRDate.civil(2007,2,27) - :hello }.should raise_error(TypeError)
    lambda { MRDate.civil(2007,2,27) - "hello" }.should raise_error(TypeError)
    lambda { MRDate.civil(2007,2,27) - Object.new }.should raise_error(TypeError)
  end
  
end