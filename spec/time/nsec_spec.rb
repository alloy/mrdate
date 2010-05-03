require File.expand_path('../../spec_helper', __FILE__)
require File.expand_path('../shared/nsec', __FILE__)

describe "MRTime#nsec" do
  it_behaves_like :time_nsec, :nsec
end