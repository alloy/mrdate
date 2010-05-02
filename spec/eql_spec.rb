require File.expand_path('../spec_helper', __FILE__)

describe "MRDate#eql?" do
  it "should be able determine equality between date objects" do
    MRDate.civil(2007, 10, 11).should eql(MRDate.civil(2007, 10, 11))
    # MRDate.civil(2007, 10, 11).should eql(MRDate.civil(2007, 10, 12) - 1)
    MRDate.civil(2007, 10, 11).should_not eql(MRDate.civil(2007, 10, 12))
  end
end