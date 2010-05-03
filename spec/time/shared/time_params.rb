describe :time_params, :shared => true do
  it "handles string-like second argument" do
    MRTime.send(@method, 2008, "12").should  == MRTime.send(@method, 2008, 12)
    MRTime.send(@method, 2008, "dec").should == MRTime.send(@method, 2008, 12)
    (obj = mock('12')).should_receive(:to_str).and_return("12")
    MRTime.send(@method, 2008, obj).should == MRTime.send(@method, 2008, 12)
  end

  ruby_bug "#", "1.8.6.114" do
    # Exclude MRI 1.8.6 because it segfaults. :)
    # But the problem is fixed in MRI repository already.
    it "handles string-like second argument" do
      (obj = mock('dec')).should_receive(:to_str).and_return('dec')
      MRTime.send(@method, 2008, obj).should == MRTime.send(@method, 2008, 12)
    end
  end

  it "handles string arguments" do
    MRTime.send(@method, "2000", "1", "1" , "20", "15", "1").should == MRTime.send(@method, 2000, 1, 1, 20, 15, 1)
    MRTime.send(@method, "1", "15", "20", "1", "1", "2000", :ignored, :ignored, :ignored, :ignored).should == MRTime.send(@method, 1, 15, 20, 1, 1, 2000, :ignored, :ignored, :ignored, :ignored)
  end

  it "handles float arguments" do
    MRTime.send(@method, 2000.0, 1.0, 1.0, 20.0, 15.0, 1.0).should == MRTime.send(@method, 2000, 1, 1, 20, 15, 1)
    MRTime.send(@method, 1.0, 15.0, 20.0, 1.0, 1.0, 2000.0, :ignored, :ignored, :ignored, :ignored).should == MRTime.send(@method, 1, 15, 20, 1, 1, 2000, :ignored, :ignored, :ignored, :ignored)
  end

  ruby_version_is ""..."1.9.1" do
    it "should accept various year ranges" do
      MRTime.send(@method, 1901, 12, 31, 23, 59, 59, 0).wday.should == 2
      MRTime.send(@method, 2037, 12, 31, 23, 59, 59, 0).wday.should == 4

      platform_is :wordsize => 32 do
        lambda { MRTime.send(@method, 1900, 12, 31, 23, 59, 59, 0) }.should raise_error(ArgumentError) # mon
        lambda { MRTime.send(@method, 2038, 12, 31, 23, 59, 59, 0) }.should raise_error(ArgumentError) # mon
      end

      platform_is :wordsize => 64 do
        MRTime.send(@method, 1900, 12, 31, 23, 59, 59, 0).wday.should == 1
        MRTime.send(@method, 2038, 12, 31, 23, 59, 59, 0).wday.should == 5
      end
    end

    it "raises an ArgumentError for out of range values" do
      # year-based MRTime.local(year (, month, day, hour, min, sec, usec))
      # Year range only fails on 32 bit archs
      platform_is :wordsize => 32 do
        lambda { MRTime.send(@method, 1111, 12, 31, 23, 59, 59, 0) }.should raise_error(ArgumentError) # year
      end
      lambda { MRTime.send(@method, 2008, 13, 31, 23, 59, 59, 0) }.should raise_error(ArgumentError) # mon
      lambda { MRTime.send(@method, 2008, 12, 32, 23, 59, 59, 0) }.should raise_error(ArgumentError) # day
      lambda { MRTime.send(@method, 2008, 12, 31, 25, 59, 59, 0) }.should raise_error(ArgumentError) # hour
      lambda { MRTime.send(@method, 2008, 12, 31, 23, 61, 59, 0) }.should raise_error(ArgumentError) # min
      lambda { MRTime.send(@method, 2008, 12, 31, 23, 59, 61, 0) }.should raise_error(ArgumentError) # sec

      # second based MRTime.local(sec, min, hour, day, month, year, wday, yday, isdst, tz)
      lambda { MRTime.send(@method, 61, 59, 23, 31, 12, 2008, :ignored, :ignored, :ignored, :ignored) }.should raise_error(ArgumentError) # sec
      lambda { MRTime.send(@method, 59, 61, 23, 31, 12, 2008, :ignored, :ignored, :ignored, :ignored) }.should raise_error(ArgumentError) # min
      lambda { MRTime.send(@method, 59, 59, 25, 31, 12, 2008, :ignored, :ignored, :ignored, :ignored) }.should raise_error(ArgumentError) # hour
      lambda { MRTime.send(@method, 59, 59, 23, 32, 12, 2008, :ignored, :ignored, :ignored, :ignored) }.should raise_error(ArgumentError) # day
      lambda { MRTime.send(@method, 59, 59, 23, 31, 13, 2008, :ignored, :ignored, :ignored, :ignored) }.should raise_error(ArgumentError) # month
      # Year range only fails on 32 bit archs
      platform_is :wordsize => 32 do
        lambda { MRTime.send(@method, 59, 59, 23, 31, 12, 1111, :ignored, :ignored, :ignored, :ignored) }.should raise_error(ArgumentError) # year
      end
    end
  end

  # MRI 1.9 relaxes 1.8's restriction's on allowed years.
  ruby_version_is "1.9" do
    it "should accept various year ranges" do
      MRTime.send(@method, 1801, 12, 31, 23, 59, 59, 0).wday.should == 4
      MRTime.send(@method, 3000, 12, 31, 23, 59, 59, 0).wday.should == 3
    end  

    it "raises an ArgumentError for out of range values" do
      # year-based MRTime.local(year (, month, day, hour, min, sec, usec))
      # Year range only fails on 32 bit archs
      platform_is :wordsize => 32 do
      end
      lambda { MRTime.send(@method, 2008, 13, 31, 23, 59, 59, 0) }.should raise_error(ArgumentError) # mon
      lambda { MRTime.send(@method, 2008, 12, 32, 23, 59, 59, 0) }.should raise_error(ArgumentError) # day
      lambda { MRTime.send(@method, 2008, 12, 31, 25, 59, 59, 0) }.should raise_error(ArgumentError) # hour
      lambda { MRTime.send(@method, 2008, 12, 31, 23, 61, 59, 0) }.should raise_error(ArgumentError) # min
      lambda { MRTime.send(@method, 2008, 12, 31, 23, 59, 61, 0) }.should raise_error(ArgumentError) # sec

      # second based MRTime.local(sec, min, hour, day, month, year, wday, yday, isdst, tz)
      lambda { MRTime.send(@method, 61, 59, 23, 31, 12, 2008, :ignored, :ignored, :ignored, :ignored) }.should raise_error(ArgumentError) # sec
      lambda { MRTime.send(@method, 59, 61, 23, 31, 12, 2008, :ignored, :ignored, :ignored, :ignored) }.should raise_error(ArgumentError) # min
      lambda { MRTime.send(@method, 59, 59, 25, 31, 12, 2008, :ignored, :ignored, :ignored, :ignored) }.should raise_error(ArgumentError) # hour
      lambda { MRTime.send(@method, 59, 59, 23, 32, 12, 2008, :ignored, :ignored, :ignored, :ignored) }.should raise_error(ArgumentError) # day
      lambda { MRTime.send(@method, 59, 59, 23, 31, 13, 2008, :ignored, :ignored, :ignored, :ignored) }.should raise_error(ArgumentError) # month
    end
  end

  it "throws ArgumentError for invalid number of arguments" do
    # MRTime.local only takes either 1-8, or 10 arguments
    lambda {
      MRTime.send(@method, 59, 1, 2, 3, 4, 2008, 0, 0, 0)
    }.should raise_error(ArgumentError) # 9 go boom

    # please stop using should_not raise_error... it is implied
    MRTime.send(@method, 2008).wday.should == 2
    MRTime.send(@method, 2008, 12).wday.should == 1
    MRTime.send(@method, 2008, 12, 31).wday.should == 3
    MRTime.send(@method, 2008, 12, 31, 23).wday.should == 3
    MRTime.send(@method, 2008, 12, 31, 23, 59).wday.should == 3
    MRTime.send(@method, 2008, 12, 31, 23, 59, 59).wday.should == 3
    MRTime.send(@method, 2008, 12, 31, 23, 59, 59, 0).wday.should == 3
    MRTime.send(@method, 59, 1, 2, 3, 4, 2008, :x, :x, :x, :x).wday.should == 4
  end
end
