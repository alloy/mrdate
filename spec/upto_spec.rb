require 'date' 
require File.expand_path('../../../spec_helper', __FILE__)

describe "MRDate#upto" do
  
  it "should be able to step forward in time" do
    ds    = MRDate.civil(2008, 10, 11)
    de    = MRDate.civil(2008,  9, 29)
    count = 0
    de.upto(ds) do |d|
      d.should <= ds
      d.should >= de
      count += 1
    end
    count.should == 13
  end

end