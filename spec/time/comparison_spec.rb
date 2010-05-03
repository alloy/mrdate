require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/methods', __FILE__)

describe "MRTime#<=>" do
  it "returns 1 if the first argument is a point in time after the second argument" do
    (MRTime.now <=> MRTime.at(0)).should == 1
    (MRTime.at(0, 100) <=> MRTime.at(0, 0)).should == 1
    (MRTime.at(1202778512, 100) <=> MRTime.at(1202778512, 99)).should == 1
  end
  
  it "returns 0 if time is the same as other" do
    (MRTime.at(1202778513) <=> MRTime.at(1202778513)).should == 0
    (MRTime.at(100, 100) <=> MRTime.at(100, 100)).should == 0
  end
  
  it "returns -1 if the first argument is a point in time before the second argument" do
    (MRTime.at(0) <=> MRTime.now).should == -1
    (MRTime.at(0, 0) <=> MRTime.at(0, 100)).should == -1
    (MRTime.at(100, 100) <=> MRTime.at(101, 100)).should == -1
  end

  # see [ruby-core:15333]
  it "returns nil when MRTime is compared to Numeric" do
    (MRTime.at(100) <=> 100).should == nil
    (MRTime.at(100) <=> 100.0).should == nil
  end

  it "returns nil when MRTime is compared to some Object" do
    (MRTime.at(100) <=> Object.new).should == nil
  end
end
