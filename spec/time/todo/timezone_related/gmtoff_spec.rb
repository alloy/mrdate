require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/methods', __FILE__)
require File.expand_path('../shared/gmt_offset', __FILE__)

describe "MRTime#gmtoff" do
  it_behaves_like(:time_gmt_offset, :gmtoff)
end
