require File.expand_path('../../spec_helper', __FILE__)

describe "MRTime#monday?" do
  it "returns whether or not the time is on a monday" do
    # unix epoch time is a thursday
    day = 3600 * 24
    
    monday = MRTime.at(day * 4)
    monday.monday?.should == true
    
    1.upto(6) do |day_offset|
      time = monday + (day * day_offset)
      time.monday?.should == false
    end
  end
end
