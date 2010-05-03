describe :inspect, :shared => true do
  it "formats the time following the pattern 'yyyy-MM-dd HH:mm:ss Z'" do
    with_timezone("PST", +1) do
      MRTime.local("1", "15", "20", "1", "1", "2000", :ignored, :ignored, :ignored, :ignored).send(@method).should == "2000-01-01 20:15:01 +0100"
    end
  end
  
  it "formats the UTC time following the pattern 'yyyy-MM-dd HH:mm:ss UTC'" do
    MRTime.utc("1", "15", "20", "1", "1", "2000", :ignored, :ignored, :ignored, :ignored).send(@method).should == "2000-01-01 20:15:01 UTC"
  end
end
