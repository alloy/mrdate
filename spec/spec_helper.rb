require File.expand_path("../../mrdate", __FILE__)

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
  
  def raise_error(type)
    lambda do |block|
      begin
        block.should.raise(type)
        true
      rescue Bacon::Error
        false
      end
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