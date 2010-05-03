require File.expand_path('../../spec_helper', __FILE__)

describe "MRTime#sunday?" do
  it "returns whether or not the time is on a sunday" do
    # unix epoch time is a thursday
    day = 3600 * 24
    
    sunday = MRTime.at(day * 3)
    sunday.sunday?.should == true
    
    1.upto(6) do |day_offset|
      time = sunday + (day * day_offset)
      time.sunday?.should == false
    end
  end
end