require File.expand_path('../spec_helper', __FILE__)

describe "MRDate#===" do

  it "should be able to compare two same dates" do
    (MRDate.civil(2000, 04, 06) === MRDate.civil(2000, 04, 06)).should == true
    (MRDate.civil(2000, 04, 06) === MRDate.civil(2000, 04, 07)).should == false
  end

  it "should be able to compare to another numeric" do
    (MRDate.civil(2000, 04, 06) === MRDate.civil(2000, 04, 06).jd).should == true
    (MRDate.civil(2000, 04, 06) === MRDate.civil(2000, 04, 07).jd).should == false
  end

  it "returns false for any non numeric or dates" do
    (MRDate.civil(2000, 04, 06) === "2000-04-06").should == false
    (MRDate.civil(2000, 04, 06) === :"2000-04-06").should == false
  end
end