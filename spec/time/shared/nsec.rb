describe :time_nsec, :shared => true do
  it "returns the nanoseconds for time" do
    MRTime.at(0).send(@method).should == 0
    (MRTime.at(1.1) + 0.9).send(@method).should == 0
    MRTime.at(0, 123456789).send(@method).should == 456789000
  end
end