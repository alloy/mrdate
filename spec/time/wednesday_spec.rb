require File.expand_path('../../spec_helper', __FILE__)

describe "MRTime#wednesday?" do
  it "returns whether or not the time is on a wednesday" do
    # unix epoch time is a thursday
    day = 3600 * 24
    
    wednesday = MRTime.at(day * 6)
    wednesday.wednesday?.should == true
    
    1.upto(6) do |day_offset|
      time = wednesday + (day * day_offset)
      time.wednesday?.should == false
    end
  end
end