require File.expand_path('../../spec_helper', __FILE__)
require File.expand_path('../fixtures/methods', __FILE__)

describe "MRTime#-" do
  #see [ruby-dev:38446]
  it "decrements the time by the specified amount" do
    (MRTime.at(100) - 100).should == MRTime.at(0)
    (MRTime.at(100) - MRTime.at(99)).should == 1
    # (MRTime.at(Rational(11, 10)) - Rational(2, 10)).should == MRTime.at(Rational(9, 10))
  end

  #see [ruby-dev:38446]
  it "accepts arguments that can be coerced into Rational" do
    # (obj = mock('10')).should_receive(:to_r).and_return(Rational(10))
    obj = Object.new
    def obj.to_r; Rational(10); end
    (MRTime.at(100) - obj).should == MRTime.at(90)
  end

  it "raises TypeError on argument that can't be coerced into Rational" do
    lambda { MRTime.now - Object.new }.should raise_error(TypeError)
    # lambda { MRTime.now - "stuff" }.should raise_error(TypeError) # passes on 1.9
  end

  it "raises TypeError on nil argument" do
    lambda { MRTime.now - nil }.should raise_error(TypeError)
  end

  it "tracks microseconds" do
    time = MRTime.at(Rational(777777, 1000000))
    time -= Rational(654321, 1000000)
    time.usec.should == 123456
    time -= Rational(123456, 1000000)
    time.usec.should == 0
  end
end