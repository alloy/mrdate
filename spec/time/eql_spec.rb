require File.expand_path('../../spec_helper', __FILE__)
require File.expand_path('../fixtures/methods', __FILE__)

describe "MRTime#eql?" do
  it "returns true iff time is equal in seconds and usecs to other time" do
    MRTime.at(100, 100).should eql(MRTime.at(100, 100))
    MRTime.at(100, 100).should_not eql(MRTime.at(100, 99))
    MRTime.at(100, 100).should_not eql(MRTime.at(99, 100))
  end  
end
