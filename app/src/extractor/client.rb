require_relative 'configurable'

module Extractor
  class Client
    include Extractor::Configurable
    
    def initialize(config={})
      Extractor::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", config[key] || Extractor.instance_variable_get(:"@#{key}"))
      end
      
      @embedly = Embedly::API.new(config)
    end
    
    def extract(url)
      return format(@embedly.extract(url: url)[0].marshal_dump)
    end
    
    def format(site)
      {
        name:        site[:title],
        description: site[:description],
        thumbnail:   thumbnail(site[:images]),
        url:         site[:url]
      }
    end
    
    def thumbnail(images)
      if images.size > 0
        images.sort{|a,b| (b["width"].to_i*b["height"].to_i) <=> (a["width"].to_i*a["height"].to_i) }[0]["url"]
      else
        nil
      end
    end
    
  end
end