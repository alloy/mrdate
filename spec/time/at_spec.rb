require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/methods', __FILE__)

describe "MRTime.at" do
  platform_is_not :windows do
    ruby_version_is ""..."1.9" do
      it "converts to time object" do
        # the #chomp calls are necessary because of RSpec
        MRTime.at(1184027924).inspect.chomp.should == localtime_18(1184027924).chomp
      end
    end

    ruby_version_is "1.9" do
      it "converts to time object" do
        # the #chomp calls are necessary because of RSpec
        MRTime.at(1184027924).inspect.chomp.should == localtime_19(1184027924).chomp
      end
    end
  end

  it "creates a new time object with the value given by time" do
    t = MRTime.now
    MRTime.at(t).inspect.should == t.inspect
  end
  
  it "creates a dup time object with the value given by time" do
    t1 = MRTime.new
    t2 = MRTime.at(t1)
    t1.object_id.should_not == t2.object_id
  end
  
  it "is able to create a time object with a float" do
    t = MRTime.at(10.5)
    t.usec.should == 500000.0
    t.should_not == MRTime.at(10)
  end

  it "is able to create a time object with a microseconds" do
    t = MRTime.at(10, 500000)
    t.usec.should == 500000.0
    t.should_not == MRTime.at(10)
  end

end
