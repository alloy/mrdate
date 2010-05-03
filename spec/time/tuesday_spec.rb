require File.expand_path('../../spec_helper', __FILE__)

describe "MRTime#tuesday?" do
  it "returns whether or not the time is on a tuesday" do
    # unix epoch time is a thursday
    day = 3600 * 24
    
    tuesday = MRTime.at(day * 5)
    tuesday.tuesday?.should == true
    
    1.upto(6) do |day_offset|
      time = tuesday + (day * day_offset)
      time.tuesday?.should == false
    end
  end
end
