require File.expand_path('../../fixtures/methods', __FILE__)

describe :time_isdst, :shared => true do
  it "dst? returns whether time is during daylight saving time" do
    with_timezone("America/Los_Angeles") do
      MRTime.local(2007, 9, 9, 0, 0, 0).send(@method).should == true
      MRTime.local(2007, 1, 9, 0, 0, 0).send(@method).should == false
    end
  end
end
