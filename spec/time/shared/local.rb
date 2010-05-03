describe :time_local, :shared => true do
  it "creates a time based on given values, interpreted in the local time zone" do
    with_timezone("PST", -8) do
      # MRTime.send(@method, 2000,"jan",1,20,15,1).inspect.should == "2000-01-01 20:15:01 -0800"
      MRTime.send(@method, 2000,1,1,20,15,1).inspect.should == "2000-01-01 20:15:01 -0800"
    end
  end

  # it "creates a time based on given C-style gmtime arguments, interpreted in the local time zone" do
  #   with_timezone("PST", -8) do
  #     time = MRTime.send(@method, 1, 15, 20, 1, 1, 2000, :ignored, :ignored, :ignored, :ignored)
  #     time.inspect.should == "2000-01-01 20:15:01 -0800"
  #   end
  # end
end
