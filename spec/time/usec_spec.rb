require File.expand_path('../../spec_helper', __FILE__)
require File.expand_path('../fixtures/methods', __FILE__)

describe "MRTime#usec" do
  it "returns the microseconds for time" do
    MRTime.at(0).usec.should == 0
    (MRTime.at(1.1) + 0.9).usec.should == 0
    (MRTime.at(1.1) - 0.2).usec.should == 900000
  end
end
