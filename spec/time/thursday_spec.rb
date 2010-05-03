require File.expand_path('../../spec_helper', __FILE__)

describe "MRTime#thursday?" do
  it "returns whether or not the time is on a thursday" do
    # unix epoch time is a thursday
    day = 3600 * 24
    
    thursday = MRTime.at(0)
    thursday.thursday?.should == true
    
    1.upto(6) do |day_offset|
      time = thursday + (day * day_offset)
      time.thursday?.should == false
    end
  end
end