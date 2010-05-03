# require File.expand_path("../../mrdate", __FILE__)
require File.expand_path("../../mrtime", __FILE__)

require "rubygems"
require "bacon"

Bacon.summary_on_exit

class Bacon::Context
  def it_behaves_like(like, method)
    @method = method
    behaves_like(like)
  end
  
  def not_compliant_on(platform)
    yield unless platform == :macruby
  end
  alias_method :platform_is_not, :not_compliant_on
  
  def eql(object)
    lambda { |o| o.eql?(object) }
  end
  
  def raise_error(type)
    lambda { |block| run_assertion { block.should.raise(type) } }
  end
  
  def be_close(actual, delta)
    lambda { |obj| run_assertion { obj.should.be.close(actual, delta) } }
  end
  
  private
  
  def run_assertion
    begin
      yield
      true
    rescue Bacon::Error
      false
    end
  end
end

def describe(name, options = {}, &block)
  if options[:shared]
    shared(name, &block)
  else
    super
  end
end

class Object
  def should_not(result)
    should.not result
  end
end