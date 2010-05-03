require File.expand_path('../../spec_helper', __FILE__)
require File.expand_path('../fixtures/methods', __FILE__)

describe "MRTime#hash" do
  it "returns a Fixnum" do
    MRTime.at(100).hash.should.be.instance_of(Fixnum)
  end  
  
  it "is stable" do
    MRTime.at(1234).hash.should == MRTime.at(1234).hash
  end
end
