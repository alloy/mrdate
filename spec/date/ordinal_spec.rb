require File.expand_path('../../spec_helper', __FILE__)
require File.expand_path('../shared/commercial', __FILE__)

# reference:
# October 1582 (the Gregorian calendar, Civil MRDate)
#   S   M  Tu   W  Th   F   S
#       1   2   3   4  15  16
#  17  18  19  20  21  22  23
#  24  25  26  27  28  29  30
#  31

describe "MRDate#ordinal" do

  ruby_version_is "" ... "1.9" do
    it "should be able to construct a MRDate object from an ordinal date" do
      # October 1582 (the Gregorian calendar, Ordinal MRDate in 1.8)
      #   S   M  Tu   W  Th   F   S
      #     274 275 276 277 288 289
      # 290 291 292 293 294 295 296
      # 297 298 299 300 301 302 303
      # 304
      MRDate.ordinal(1582, 274).should == MRDate.civil(1582, 10,  1)
      MRDate.ordinal(1582, 277).should == MRDate.civil(1582, 10,  4)
      lambda { MRDate.ordinal(1582, 278) }.should raise_error(ArgumentError)
      lambda { MRDate.ordinal(1582, 287) }.should raise_error(ArgumentError)
      MRDate.ordinal(1582, 288).should == MRDate.civil(1582, 10, 15)
      MRDate.ordinal(1582, 287, MRDate::ENGLAND).should == MRDate.civil(1582, 10, 14, MRDate::ENGLAND)
    end
  end

  ruby_version_is "1.9" do
    it "should be able to construct a MRDate object from an ordinal date" do
      # October 1582 (the Gregorian calendar, Ordinal MRDate in 1.9)
      #   S   M  Tu   W  Th   F   S
      #     274 275 276 277 278 279
      # 280 281 282 283 284 285 286
      # 287 288 289 290 291 292 293
      # 294
      MRDate.ordinal(1582, 274).should == MRDate.civil(1582, 10,  1)
      MRDate.ordinal(1582, 277).should == MRDate.civil(1582, 10,  4)
      MRDate.ordinal(1582, 278).should == MRDate.civil(1582, 10, 15)
      MRDate.ordinal(1582, 287, MRDate::ENGLAND).should == MRDate.civil(1582, 10, 14, MRDate::ENGLAND)
    end
  end

end

describe "MRDate#valid_ordinal?" do

  ruby_version_is "" ... "1.9" do
    it "should be able to determine if the date is a valid ordinal date" do
      # October 1582 (the Gregorian calendar, Ordinal MRDate in 1.8)
      #   S   M  Tu   W  Th   F   S
      #     274 275 276 277 278 279
      # 280 281 282 283 284 285 286
      # 287 288 289 290 291 292 293
      # 294
      MRDate.valid_ordinal?(1582, 277).should == MRDate.civil(1582, 10,  4).jd
      MRDate.valid_ordinal?(1582, 278).should == nil
      MRDate.valid_ordinal?(1582, 287).should == nil
      MRDate.valid_ordinal?(1582, 288).should == MRDate.civil(1582, 10, 15).jd
      MRDate.valid_ordinal?(1582, 287, MRDate::ENGLAND).should_not == nil
      MRDate.valid_ordinal?(1582, 287, MRDate::ENGLAND).should == MRDate.civil(1582, 10, 14, MRDate::ENGLAND).jd
    end

    it "should be able to handle negative day numbers" do
      # October 1582 (the Gregorian calendar, Ordinal MRDate in 1.8)
      #   S   M  Tu   W  Th   F   S
      #     -92 -91 -90 -89 -78 -77
      # -76 -75 -74 -73 -72 -71 -70
      # -69 -68 -67 -66 -65 -64 -63
      # -62
      MRDate.valid_ordinal?(1582, -89).should == MRDate.civil(1582, 10,  4).jd
      MRDate.valid_ordinal?(1582, -88).should == nil
      MRDate.valid_ordinal?(1582, -79).should == nil
      MRDate.valid_ordinal?(1582, -78).should == MRDate.civil(1582, 10, 15).jd
      MRDate.valid_ordinal?(2007, -100).should == MRDate.valid_ordinal?(2007, 266)
    end
  end

  ruby_version_is "1.9" do
    it "should be able to determine if the date is a valid ordinal date" do
      # October 1582 (the Gregorian calendar, Ordinal MRDate in 1.9)
      #   S   M  Tu   W  Th   F   S
      #     274 275 276 277 278 279
      # 280 281 282 283 284 285 286
      # 287 288 289 290 291 292 293
      # 294
      MRDate.valid_ordinal?(1582, 277).should == true
      MRDate.valid_ordinal?(1582, 278).should == true
      MRDate.valid_ordinal?(1582, 287).should == true
      MRDate.valid_ordinal?(1582, 288).should == true
    end

    it "should be able to handle negative day numbers" do
      # October 1582 (the Gregorian calendar, Ordinal MRDate in 1.9)
      #   S   M  Tu   W  Th   F   S
      #     -82 -81 -80 -79 -78 -77
      # -76 -75 -74 -73 -72 -71 -70
      # -69 -68 -67 -66 -65 -64 -63
      # -62
      MRDate.valid_ordinal?(1582, -79).should == true
      MRDate.valid_ordinal?(1582, -78).should == true
      MRDate.valid_ordinal?(2007, -100).should == true
    end
  end

end