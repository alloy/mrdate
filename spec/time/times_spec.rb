require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../../../shared/process/times', __FILE__)

describe 'MRTime.times' do
  ruby_version_is "" ... "1.9" do
    it_behaves_like :process_times, :times, MRTime
  end
end
