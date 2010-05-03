require File.expand_path('../../spec_helper', __FILE__)

describe "MRTime#to_r" do
  it "returns the rational number of seconds + usecs since the epoch" do
    MRTime.at(1.1).to_r.should == 1.1.to_r
  end

  it "returns the numerator of the rational number when the denominator is 1" do
    MRTime.at(2).to_r.should == 2
  end
end
