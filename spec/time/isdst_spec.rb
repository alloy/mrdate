require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/methods', __FILE__)
require File.expand_path('../shared/isdst', __FILE__)

describe "MRTime#isdst" do
  it_behaves_like(:time_isdst, :isdst)
end  
