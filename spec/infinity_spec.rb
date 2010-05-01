require 'date' 
require File.expand_path('../../../spec_helper', __FILE__)

describe "MRDate::Infinity" do

  it "should be able to check whether Infinity is zero" do
    i = MRDate::Infinity.new
    i.zero?.should == false
  end

  it "should be able to check whether Infinity is finite" do
    i1 = MRDate::Infinity.new
    i1.finite?.should == false
    i2 = MRDate::Infinity.new(-1)
    i2.finite?.should == false
    i3 = MRDate::Infinity.new(0)
    i3.finite?.should == false
  end

  it "should be able to check whether Infinity is infinite" do
    i1 = MRDate::Infinity.new
    i1.infinite?.should == 1
    i2 = MRDate::Infinity.new(-1)
    i2.infinite?.should == -1
    i3 = MRDate::Infinity.new(0)
    i3.infinite?.should == nil
  end

  it "should be able to check whether Infinity is not a number" do
    i1 = MRDate::Infinity.new
    i1.nan?.should == false
    i2 = MRDate::Infinity.new(-1)
    i2.nan?.should == false
    i3 = MRDate::Infinity.new(0)
    i3.nan?.should == true
  end

  # These checks fail on MRI because of a bug in MRDate::Infinity#<=>
  # Fixed in 1.8.7
  ruby_bug "#", "1.8.6" do
    it "should be able to compare Infinity objects" do
      i1 = MRDate::Infinity.new
      i2 = MRDate::Infinity.new(-1)
      i3 = MRDate::Infinity.new(0)
      i4 = MRDate::Infinity.new
      (i4 <=> i1).should == 0
      (i3 <=> i1).should == -1
      (i2 <=> i1).should == -1
      (i3 <=> i2).should == 1
    end
  end

  # Also fails because of the same bug as the previous spec
  # Fixed in 1.8.7
  ruby_bug "#", "1.8.6" do
    it "should be able to return plus Infinity for abs" do
      i1 = MRDate::Infinity.new
      i2 = MRDate::Infinity.new(-1)
      i3 = MRDate::Infinity.new(0)
      (i2.abs <=> i1).should == 0
      (i3.abs <=> i1).should == 0
    end
  end
  
  ruby_bug "#222", "1.8.6" do
    it "should be able to use -@ and +@ for MRDate::Infinity" do
      (MRDate::Infinity.new <=> +MRDate::Infinity.new).should == 0
      (MRDate::Infinity.new(-1) <=> -MRDate::Infinity.new).should == 0
    end
  end
  
  it "should be able to coerce a MRDate::Infinity object" do
    MRDate::Infinity.new.coerce(1).should == [-1, 1]
    MRDate::Infinity.new(0).coerce(2).should == [0, 0]
    MRDate::Infinity.new(-1).coerce(1.5).should == [1, -1]
  end
end
