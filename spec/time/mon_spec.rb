require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/methods', __FILE__)
require File.expand_path('../shared/month', __FILE__)

describe "MRTime#mon" do
  it_behaves_like(:time_month, :mon)
end
