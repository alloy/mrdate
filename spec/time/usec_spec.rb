require File.expand_path('../../spec_helper', __FILE__)
require File.expand_path('../shared/usec', __FILE__)

describe "MRTime#usec" do
  it_behaves_like(:time_usec, :usec)
end
