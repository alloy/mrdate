require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/methods', __FILE__)
require File.expand_path('../shared/inspect', __FILE__)

describe "MRTime.inspect" do
  it_behaves_like :inspect, :inspect
end

describe "MRTime#inspect" do
  it "needs to be reviewed for spec completeness"
end
