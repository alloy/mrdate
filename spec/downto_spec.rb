require File.expand_path('../spec_helper', __FILE__)

describe "MRDate#downto" do

  it "should be able to step backward in time" do
    ds    = MRDate.civil(2000, 4, 14)
    de    = MRDate.civil(2000, 3, 29)
    count = 0
    ds.downto(de) do |d|
      d.should <= ds
      d.should >= de
      count += 1
    end
    count.should == 17
  end

end
