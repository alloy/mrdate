require File.expand_path('../../spec_helper', __FILE__)

describe "MRTime#friday?" do
  it "returns whether or not the time is on a friday" do
    # unix epoch time is a thursday
    day = 3600 * 24
    
    friday = MRTime.at(day * 1)
    friday.friday?.should == true
    
    1.upto(6) do |day_offset|
      time = friday + (day * day_offset)
      time.friday?.should == false
    end
  end
end