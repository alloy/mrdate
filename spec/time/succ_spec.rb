require File.expand_path('../../spec_helper', __FILE__)
require File.expand_path('../fixtures/methods', __FILE__)

describe "MRTime#succ" do
  it "returns a new time one second later than time" do
    MRTime.at(100).succ.should == MRTime.at(101)
  end
  
  it "returns a new instance" do
    t1 = MRTime.at(100)
    t2 = t1.succ
    t1.object_id.should.not == t2.object_id
  end
end
