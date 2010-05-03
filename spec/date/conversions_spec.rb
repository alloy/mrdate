require File.expand_path('../../spec_helper', __FILE__)

describe "MRDate#new_start" do
  it "should convert a date object into another with a new calendar reform" do
    MRDate.civil(1582, 10, 14, MRDate::ENGLAND).new_start.should == MRDate.civil(1582, 10, 24)
    MRDate.civil(1582, 10,  4, MRDate::ENGLAND).new_start.should == MRDate.civil(1582, 10,  4)
    MRDate.civil(1582, 10, 15).new_start(MRDate::ENGLAND).should == MRDate.civil(1582, 10,  5, MRDate::ENGLAND)
    MRDate.civil(1752,  9, 14).new_start(MRDate::ENGLAND).should == MRDate.civil(1752,  9, 14, MRDate::ENGLAND)
    MRDate.civil(1752,  9, 13).new_start(MRDate::ENGLAND).should == MRDate.civil(1752,  9,  2, MRDate::ENGLAND)
  end
end

describe "MRDate#italy" do
  it "should convert a date object into another with the Italian calendar reform" do
    MRDate.civil(1582, 10, 14, MRDate::ENGLAND).italy.should == MRDate.civil(1582, 10, 24)
    MRDate.civil(1582, 10,  4, MRDate::ENGLAND).italy.should == MRDate.civil(1582, 10,  4)
  end
end

describe "MRDate#england" do
  it "should convert a date object into another with the English calendar reform" do
    MRDate.civil(1582, 10, 15).england.should == MRDate.civil(1582, 10,  5, MRDate::ENGLAND)
    MRDate.civil(1752,  9, 14).england.should == MRDate.civil(1752,  9, 14, MRDate::ENGLAND)
    MRDate.civil(1752,  9, 13).england.should == MRDate.civil(1752,  9,  2, MRDate::ENGLAND)
  end
end

describe "MRDate#julian" do
  it "should convert a date object into another with the Julian calendar" do
    MRDate.civil(1582, 10, 15).julian.should == MRDate.civil(1582, 10,  5, MRDate::JULIAN)
    MRDate.civil(1752,  9, 14).julian.should == MRDate.civil(1752,  9,  3, MRDate::JULIAN)
    MRDate.civil(1752,  9, 13).julian.should == MRDate.civil(1752,  9,  2, MRDate::JULIAN)
  end
end

describe "MRDate#gregorian" do
  it "should convert a date object into another with the Gregorian calendar" do
    MRDate.civil(1582, 10,  4).gregorian.should == MRDate.civil(1582, 10, 14, MRDate::GREGORIAN)
    MRDate.civil(1752,  9, 14).gregorian.should == MRDate.civil(1752,  9, 14, MRDate::GREGORIAN)
  end
end

# The following methods are private in 1.9's date.rb.
# XXX should we write specs that test if they are private?
# should we rewrite the specs using #send?
ruby_version_is "" ... "1.9" do

ruby_version_is "" ... "1.9" do
  describe "MRDate#ordinal_to_jd" do
    it "should convert an ordinal date (year-day) to a Julian day number" do
      MRDate.ordinal_to_jd(2007, 55).should == 2454156
    end
  end
  
  describe "MRDate#jd_to_ordinal" do
    it "should convert a Julian day number into an ordinal date" do
      MRDate.jd_to_ordinal(2454156).should == [2007, 55]
    end
  end
  
  describe "MRDate#civil_to_jd" do
    it "should convert a civil date into a Julian day number" do
      MRDate.civil_to_jd(2007, 2, 24).should == 2454156
    end
  end
  
  describe "MRDate#jd_to_civil" do
    it "should convert a Julian day into a civil date" do
      MRDate.jd_to_civil(2454156).should == [2007, 2, 24]
    end
  end
  
  describe "MRDate#commercial_to_jd" do
    it "should convert a commercial date (year - week - day of week) into a Julian day number" do
      MRDate.commercial_to_jd(2007, 45, 1).should == 2454410
    end
  end
  
  describe "MRDate#jd_to_commercial" do
    it "should convert a Julian day number into a commercial date" do
      MRDate.jd_to_commercial(2454410).should == [2007, 45, 1]
    end
  end
  
  describe "MRDate#ajd_to_jd" do
    it "should convert a Astronomical Julian day number into a Julian day number" do
      MRDate.ajd_to_jd(2454410).should == [2454410, Rational(1,2)]
      MRDate.ajd_to_jd(2454410, 1.to_r / 2).should == [2454411, 0]
    end
  end
  
  describe "MRDate#jd_to_ajd" do
    it "should convert a Julian day number into a Astronomical Julian day number" do
      MRDate.jd_to_ajd(2454410, 0).should == 2454410 - Rational(1, 2)
      MRDate.jd_to_ajd(2454410, 1.to_r / 2).should == 2454410
    end
  end
  
  describe "MRDate#day_fraction_to_time" do
    it "should be able to convert a day fraction into time" do
      MRDate.day_fraction_to_time(2).should == [48, 0, 0, 0]
      MRDate.day_fraction_to_time(1).should == [24, 0, 0, 0]
      MRDate.day_fraction_to_time(1.to_r / 2).should == [12, 0, 0, 0]
      MRDate.day_fraction_to_time(1.to_r / 7).should == [3, 25, 42, 1.to_r / 100800]
    end
  end
  
  describe "MRDate#time_to_day_fraction" do
    it "should be able to convert a time into a day fraction" do
      MRDate.time_to_day_fraction(48, 0, 0).should == 2
      MRDate.time_to_day_fraction(24, 0, 0).should == 1
      MRDate.time_to_day_fraction(12, 0, 0).should == 1.to_r / 2
      MRDate.time_to_day_fraction(10, 20, 10).should == 10.to_r / 24 + 20.to_r / (24 * 60) + 10.to_r / (24 * 60 * 60)
    end
  end
  
  describe "MRDate#amjd_to_ajd" do
    it "shoud be able to convert Astronomical Modified Julian day numbers into Astronomical Julian day numbers" do
      MRDate.amjd_to_ajd(10).should == 10 + 2400000 + 1.to_r / 2
    end
  end
  
  describe "MRDate#ajd_to_amjd" do
    it "shoud be able to convert Astronomical Julian day numbers into Astronomical Modified Julian day numbers" do
      MRDate.ajd_to_amjd(10000010).should == 10000010 - 2400000 - 1.to_r / 2
    end
  end
  
  describe "MRDate#mjd_to_jd" do
    it "shoud be able to convert Modified Julian day numbers into Julian day numbers" do
      MRDate.mjd_to_jd(2000).should == 2000 + 2400001
    end
  end
  
  describe "MRDate#jd_to_mjd" do
    it "shoud be able to convert Julian day numbers into Modified Julian day numbers" do
      MRDate.jd_to_mjd(2500000).should == 2500000 - 2400001
    end
  end
  
  describe "MRDate#ld_to_jd" do
    it "should be able to convert the number of days since the Gregorian calendar in Italy into Julian day numbers" do
      MRDate.ld_to_jd(450000).should == 450000 + 2299160
    end
  end
  
  describe "MRDate#jd_to_ld" do
    it "should be able to convert Julian day numbers into the number of days since the Gregorian calendar in Italy" do
      MRDate.jd_to_ld(2450000).should == 2450000 - 2299160
    end
  end
  
  describe "MRDate#jd_to_wday" do
    it "should be able to convert a Julian day number into a week day number" do
      MRDate.jd_to_wday(2454482).should == 3
    end
  end
end

end # "" ... "1.9"
