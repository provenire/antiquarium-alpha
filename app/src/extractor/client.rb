require_relative 'url'
require_relative 'book'
require_relative 'configurable'
require_relative 'entities'

module Extractor
  class Client
    include Extractor::URL
    include Extractor::Book
    include Extractor::Configurable
    include Extractor::Entities
    
    def initialize(config={})
      Extractor::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", config[key] || Extractor.instance_variable_get(:"@#{key}"))
      end
      
      @embedly = Embedly::API.new(config)
    end
    
    
    
  end
end