require 'date' 
require File.expand_path('../../../spec_helper', __FILE__)

describe "MRDate#<=>" do

  it "should be able to compare two same dates" do
    (MRDate.civil(2000, 04, 06) <=> MRDate.civil(2000, 04, 06)).should == 0
  end

  it "should be able to compute the difference between two dates" do
    (MRDate.civil(2000, 04, 05) <=> MRDate.civil(2000, 04, 06)).should == -1
    (MRDate.civil(2001, 04, 05) <=> MRDate.civil(2000, 04, 06)).should == 1
  end

  it "should be able to compare to another numeric" do
    (MRDate.civil(2000, 04, 05) <=> MRDate.civil(2000, 04, 06).jd).should == -1
    (MRDate.civil(2001, 04, 05) <=> MRDate.civil(2000, 04, 06).jd).should == 1
  end

end