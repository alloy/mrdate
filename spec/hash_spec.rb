require 'date' 
require File.expand_path('../../../spec_helper', __FILE__)

describe "MRDate#hash" do
  
  it "should be able determine the hash value for a date" do
    MRDate.civil(2004, 7, 12).respond_to?(:hash).should == true
  end
  
  it "should be the case that the same date results in the same hash" do 
    MRDate.civil(2004, 7, 12).hash.should == MRDate.civil(2004, 7, 12).hash
  end
  
end