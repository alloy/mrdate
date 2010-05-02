describe :date_civil, :shared => true do
  it "creates a MRDate for -4712 by default" do
    d = MRDate.send(@method)
    d.year.should    == -4712
    d.month.should   == 1
    d.day.should     == 1
    d.julian?.should == true
    d.jd.should      == 0
  end

  it "creates a date with arguments" do
    d = MRDate.send(@method, 2000, 3, 5)
    d.year.should    == 2000
    d.month.should   == 3
    d.day.should     == 5
    d.julian?.should == false
    d.jd.should      == 2451609

    # Should also work with years far in the past and future

    d = MRDate.send(@method, -9000, 7, 5)
    d.year.should    == -9000
    d.month.should   == 7
    d.day.should     == 5
    d.julian?.should == true
    d.jd.should      == -1566006

    d = MRDate.send(@method, 9000, 10, 14)
    d.year.should    == 9000
    d.month.should   == 10
    d.day.should     == 14
    d.julian?.should == false
    d.jd.should      == 5008529

  end

  it "doesn't create dates for invalid arguments" do
    lambda { MRDate.send(@method, 2000, 13, 31) }.should raise_error(ArgumentError)
    lambda { MRDate.send(@method, 2000, 12, 32) }.should raise_error(ArgumentError)
    lambda { MRDate.send(@method, 2000,  2, 30) }.should raise_error(ArgumentError)
    lambda { MRDate.send(@method, 1900,  2, 29) }.should raise_error(ArgumentError)
    lambda { MRDate.send(@method, 2000,  2, 29) }.should_not raise_error(ArgumentError)

    lambda { MRDate.send(@method, 1582, 10, 15) }.should_not raise_error(ArgumentError)
    lambda { MRDate.send(@method, 1582, 10, 14) }.should raise_error(ArgumentError)
  end

  # it "creats a MRDate for different calendar reform dates" do
  #   d1 = MRDate.send(@method, 1582, 10, 4)
  #   d1.succ.day.should == 15
  # 
  #   d2 = MRDate.send(@method, 1582, 10, 4, MRDate::ENGLAND)
  #   d2.succ.day.should == 5
  # 
  #   # Choose an arbitrary reform date
  #   r  = MRDate.send(@method, 2000, 2, 3)
  # 
  #   d3 = MRDate.send(@method, 2000, 2, 3, r.jd)
  #   (d3 - 1).day.should == 20
  #   (d3 - 1).month.should == 1
  # 
  #   lambda { MRDate.send(@method, 2000, 2, 2, r.jd) }.should raise_error(ArgumentError)
  # end

  # bigdecimal is not implemented yet in macruby
  not_compliant_on :macruby do
    ruby_bug "1589", "1.8.6.368" do
      require 'bigdecimal'
      require 'bigdecimal/util'
      it "doesn't blow up (illegal instruction and segfault, respectively) when fed huge numbers" do
        ["9E69999999","1"*10000000].each do |dv|
          lambda { MRDate.new(2002,10,dv.to_d) }.should raise_error(BigDecimal::FloatDomainError)
        end
      end
    end
  end
end
