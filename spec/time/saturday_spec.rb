require File.expand_path('../../spec_helper', __FILE__)

describe "MRTime#saturday?" do
  it "returns whether or not the time is on a saturday" do
    # unix epoch time is a thursday
    day = 3600 * 24
    
    saturday = MRTime.at(day * 2)
    saturday.saturday?.should == true
    
    1.upto(6) do |day_offset|
      time = saturday + (day * day_offset)
      time.saturday?.should == false
    end
  end
end