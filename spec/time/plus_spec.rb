require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/methods', __FILE__)

describe "MRTime#+" do
  it "increments the time by the specified amount" do
    (MRTime.at(0) + 100).should == MRTime.at(100)
  end

  it "is a commutative operator" do
    (MRTime.at(1.1) + 0.9).should == MRTime.at(0.9) + 1.1
  end

  ruby_version_is "" ... "1.9" do
    it "rounds micro seconds rather than truncates" do
      # The use of 8.9999999 is intentional. This is because
      # MRTime treats the fractional part as the number of micro seconds.
      # Thusly it multiplies the result by 1_000_000 to go from
      # seconds to microseconds. That conversion should be rounded
      # properly. In this case, it's rounded up to 1,000,000, and thus
      # contributes a full extra second to the MRTime object.
      t = MRTime.at(0) + 8.9999999
      t.should == MRTime.at(9)
      t.usec.should == 0

      # Check the non-edge case works properly, that the fractional part
      # contributes to #usecs
      t2 = MRTime.at(0) + 8.9
      t2.usec.should == 900000
    end

    it "adds a negative Float" do
      t = MRTime.at(100) + -1.3
      t.usec.should == 700000
      t.to_i.should == 98
    end
  end

  ruby_version_is "1.9" do
    it "does NOT round" do
      t = MRTime.at(0) + Rational(8_999_999_999_999_999, 1_000_000_000_000_000)
      t.should_not == MRTime.at(9)
      t.usec.should == 999_999
      t.nsec.should == 999_999_999
      t.subsec.should == Rational(999_999_999_999_999, 1_000_000_000_000_000)
    end

    it "adds a negative Float" do
      t = MRTime.at(100) + -1.3
      t.usec.should == 699999
      t.to_i.should == 98
    end
  end

  ruby_version_is "" ... "1.9" do
    it "increments the time by the specified amount as float numbers" do
      (MRTime.at(1.1) + 0.9).should == MRTime.at(2)
    end

    it "accepts arguments that can be coerced into Float" do
      (obj = mock('10.5')).should_receive(:to_f).and_return(10.5)
      (MRTime.at(100) + obj).should == MRTime.at(110.5)
    end

    it "raises TypeError on argument that can't be coerced into Float" do
      lambda { MRTime.now + Object.new }.should raise_error(TypeError)
      lambda { MRTime.now + "stuff" }.should raise_error(TypeError)
    end
  end

  ruby_version_is "1.9" do
    it "increments the time by the specified amount as rational numbers" do
      (MRTime.at(Rational(11, 10)) + Rational(9, 10)).should == MRTime.at(2)
    end

    it "accepts arguments that can be coerced into Rational" do
      (obj = mock('10')).should_receive(:to_r).and_return(Rational(10))
      (MRTime.at(100) + obj).should == MRTime.at(110)
    end

    it "raises TypeError on argument that can't be coerced into Rational" do
      lambda { MRTime.now + Object.new }.should raise_error(TypeError)
      lambda { MRTime.now + "stuff" }.should raise_error(TypeError)
    end

    #see [ruby-dev:38446]
    it "tracks microseconds" do
      time = MRTime.at(0)
      time += Rational(123456, 1000000)
      time.usec.should == 123456
      time += Rational(654321, 1000000)
      time.usec.should == 777777
    end
  end

  it "raises TypeError on MRTime argument" do
    lambda { MRTime.now + MRTime.now }.should raise_error(TypeError)
  end

  it "raises TypeError on nil argument" do
    lambda { MRTime.now + nil }.should raise_error(TypeError)
  end
end
