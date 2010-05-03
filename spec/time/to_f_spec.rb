require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/methods', __FILE__)

describe "MRTime#to_f" do
  it "returns the float number of seconds + usecs since the epoch" do
    MRTime.at(100, 100).to_f.should == 100.0001
  end
end
