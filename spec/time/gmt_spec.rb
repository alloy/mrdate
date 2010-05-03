require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/methods', __FILE__)

describe "MRTime#gmt?" do
  it "returns true if time represents a time in UTC (GMT)" do
    MRTime.now.gmt?.should == false
    MRTime.now.gmtime.gmt?.should == true
  end
end
