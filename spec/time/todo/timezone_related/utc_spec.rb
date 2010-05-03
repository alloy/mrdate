require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/methods', __FILE__)
require File.expand_path('../shared/gm', __FILE__)
require File.expand_path('../shared/gmtime', __FILE__)
require File.expand_path('../shared/time_params', __FILE__)

describe "MRTime#utc?" do
  it "returns true if time represents a time in UTC (GMT)" do
    MRTime.now.utc?.should == false
  end  
end

describe "MRTime.utc" do
  it_behaves_like(:time_gm, :utc)
  it_behaves_like(:time_params, :utc)
end

describe "MRTime#utc" do
  it_behaves_like(:time_gmtime, :utc)
end  
