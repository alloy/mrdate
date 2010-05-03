require File.expand_path('../../spec_helper', __FILE__)
require File.expand_path('../shared/commercial', __FILE__)

describe "MRDate#commercial" do

  it_behaves_like(:date_commercial, :commercial)

end

# reference:
# October 1582 (the Gregorian calendar, Civil MRDate)
#   S   M  Tu   W  Th   F   S
#       1   2   3   4  15  16
#  17  18  19  20  21  22  23
#  24  25  26  27  28  29  30
#  31

describe "MRDate#valid_commercial?" do

  ruby_version_is "" ... "1.9" do
    it "should be able to determine if the date is a valid commercial date" do
      # October 1582 (the Gregorian calendar, Commercial MRDate in 1.8)
      #      M Tu  W Th  F Sa Su
      # 41:  -  -  -  -  5  6  7
      # 42:  1  2  3  4  5  6  7
      # 43:  1  2  3  4  5  6  7
      MRDate.valid_commercial?(1582, 41, 4).should == nil
      MRDate.valid_commercial?(1582, 41, 5).should == MRDate.civil(1582, 10, 15).jd
      # valid_commercial? can't handle dates before the Gregorian calendar
      MRDate.valid_commercial?(1582, 41, 4, MRDate::ENGLAND).should == nil
      MRDate.valid_commercial?(1752, 37, 4, MRDate::ENGLAND).should == MRDate.civil(1752, 9, 14, MRDate::ENGLAND).jd
    end

    it "should be able to handle negative week and day numbers" do
      # October 1582 (the Gregorian calendar, Commercial MRDate in 1.8)
      #       M Tu  W Th  F Sa Su
      # -12:  -  -  -  - -3 -2 -1
      # -11: -7 -6 -5 -4 -3 -2 -1
      # -10: -7 -6 -5 -4 -3 -2 -1
      MRDate.valid_commercial?(1582, -12, -4).should == nil
      MRDate.valid_commercial?(1582, -12, -3).should == MRDate.civil(1582, 10, 15).jd
      
      MRDate.valid_commercial?(2007, -44, -2).should == MRDate.civil(2007, 3, 3).jd
      MRDate.valid_commercial?(2008, -44, -2).should == MRDate.civil(2008, 3, 1).jd
    end
  end

  ruby_version_is "1.9" do
    it "should be able to determine if the date is a valid commercial date" do
      # October 1582 (the Gregorian calendar, Commercial MRDate in 1.9)
      #      M Tu  W Th  F Sa Su
      # 39:  1  2  3  4  5  6  7
      # 40:  1  2  3  4  5  6  7
      # 41:  1  2  3  4  5  6  7
      MRDate.valid_commercial?(1582, 39, 4).should == true
      MRDate.valid_commercial?(1582, 39, 5).should == true
      MRDate.valid_commercial?(1582, 41, 4).should == true
      MRDate.valid_commercial?(1582, 41, 5).should == true
      MRDate.valid_commercial?(1582, 41, 4, MRDate::ENGLAND).should == true
      MRDate.valid_commercial?(1752, 37, 4, MRDate::ENGLAND).should == true
    end

    it "should be able to handle negative week and day numbers" do
      # October 1582 (the Gregorian calendar, Commercial MRDate in 1.9)
      #       M Tu  W Th  F Sa Su
      # -12: -7 -6 -5 -4 -3 -2 -1
      # -11: -7 -6 -5 -4 -3 -2 -1
      # -10: -7 -6 -5 -4 -3 -2 -1
      MRDate.valid_commercial?(1582, -12, -4).should == true
      MRDate.valid_commercial?(1582, -12, -3).should == true
      
      MRDate.valid_commercial?(2007, -44, -2).should == true
      MRDate.valid_commercial?(2008, -44, -2).should == true
    end
  end

end