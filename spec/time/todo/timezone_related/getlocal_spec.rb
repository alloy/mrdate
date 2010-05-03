require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/methods', __FILE__)

describe "MRTime#getlocal" do
  it "returns a new time which is the local representation of time" do
    # Testing with America/Regina here because it doesn't have DST.
    with_timezone("CST", -6) do
      t = MRTime.gm(2007, 1, 9, 12, 0, 0)
      t.localtime.should == MRTime.local(2007, 1, 9, 6, 0, 0)
    end
  end
end
