require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/methods', __FILE__)
require File.expand_path('../shared/gmt_offset', __FILE__)

describe "MRTime#utc_offset" do
  it_behaves_like(:time_gmt_offset, :utc_offset)
end
