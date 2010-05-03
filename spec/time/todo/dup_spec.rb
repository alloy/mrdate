require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/methods', __FILE__)

describe "MRTime#dup" do
  it "returns a MRTime object that represents the same time" do
	  t = MRTime.at(100)
	  t.dup.tv_sec.should == t.tv_sec
  end

  it "copies the gmt state flag" do
	  MRTime.now.gmtime.dup.gmt?.should == true
  end

  it "returns an independent MRTime object" do
	  t = MRTime.now
	  t2 = t.dup
	  t.gmtime

	  t2.gmt?.should == false
  end
end
