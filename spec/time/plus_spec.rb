require File.expand_path('../../spec_helper', __FILE__)
require File.expand_path('../fixtures/methods', __FILE__)

describe "MRTime#+" do
  it "increments the time by the specified amount" do
    (MRTime.at(0) + 100).should == MRTime.at(100)
  end

  it "is a commutative operator" do
    (MRTime.at(1.1) + 0.9).should == MRTime.at(0.9) + 1.1
    (MRTime.at(1.1) + 0.9).should == MRTime.at(0.9) + 1.1
  end

  # it "does NOT round" do
  #   p Rational(8_999_999_999_999_999, 1_000_000_000_000_000).to_f
  #   t = MRTime.at(0) + Rational(8_999_999_999_999_999, 1_000_000_000_000_000)
  #   p MRTime.at(0).timeIntervalSince1970
  #   t.should.not == MRTime.at(9)
  #   # t.usec.should == 999_999
  #   # t.nsec.should == 999_999_999
  #   # t.subsec.should == Rational(999_999_999_999_999, 1_000_000_000_000_000)
  # end

  # it "adds a negative Float" do
  #   t = MRTime.at(100) + -1.3
  #   t.usec.should == 699999
  #   t.to_i.should == 98
  # end

  # it "increments the time by the specified amount as rational numbers" do
  #   (MRTime.at(Rational(11, 10)) + Rational(9, 10)).should == MRTime.at(2)
  # end

  it "accepts arguments that can be coerced into Rational" do
    # (obj = mock('10')).should_receive(:to_r).and_return(Rational(10))
    obj = Object.new
    def obj.to_r; Rational(10); end
    (MRTime.at(100) + obj).should == MRTime.at(110)
  end

  it "raises TypeError on argument that can't be coerced into Rational" do
    lambda { MRTime.now + Object.new }.should raise_error(TypeError)
    # lambda { MRTime.now + "stuff" }.should raise_error(TypeError) # this actually works on 1.9
  end

  #see [ruby-dev:38446]
  it "tracks microseconds" do
    time = MRTime.at(0)
    time += Rational(123456, 1000000)
    time.usec.should == 123456
    time += Rational(654321, 1000000)
    time.usec.should == 777777
  end

  it "raises TypeError on MRTime argument" do
    lambda { MRTime.now + MRTime.now }.should raise_error(TypeError)
  end

  it "raises TypeError on nil argument" do
    lambda { MRTime.now + nil }.should raise_error(TypeError)
  end
end
