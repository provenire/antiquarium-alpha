require 'json'

require_relative 'extractor/configurable'
require_relative 'extractor/client'

module Extractor
  class << self
    include Extractor::Configurable
    
    def client
      @client = Extractor::Client.new(configuration) unless defined?(@client)
      @client
    end
    
    def client?
      !!@client
    end
    
    def respond_to?(method_name, include_private=false)
      client.respond_to?(method_name, include_private) || super
    end
    
    private
    
    def method_missing(method_name, *args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    end
    
  end
end