require File.expand_path('../../spec_helper', __FILE__)

describe "MRDate constants" do

  it "should define ITALY" do
    MRDate::ITALY.should == 2299161 # 1582-10-15
  end

  it "should define ENGLAND" do
    MRDate::ENGLAND.should == 2361222 # 1752-09-14
  end
  
  # Fixes in 1.8.7
  ruby_bug "#", "1.8.6" do
    it "should define JULIAN" do
      (MRDate::JULIAN <=> MRDate::Infinity.new).should == 0
    end
  end

  # Fixed in 1.8.7
  ruby_bug "#", "1.8.6" do
    it "should define GREGORIAN" do
      (MRDate::GREGORIAN <=> -MRDate::Infinity.new).should == 0
    end
  end

  it "should define MONTHNAMES" do
    MRDate::MONTHNAMES.should == [nil] + %w(January February March April May June July
                                          August September October November December)
  end
  
  it "should define DAYNAMES" do
    MRDate::DAYNAMES.should == %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
  end
  
  it "should define ABBR_MONTHNAMES" do
    MRDate::ABBR_DAYNAMES.should == %w(Sun Mon Tue Wed Thu Fri Sat)
  end

end
