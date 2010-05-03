describe :time_usec, :shared => true do
  it "returns the microseconds for time" do
    MRTime.at(0).send(@method).should == 0
    (MRTime.at(1.1) + 0.9).send(@method).should == 0
    (MRTime.at(1.1) - 0.2).send(@method).should == 900000 # off by one
  end
end