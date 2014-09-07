module Extractor
  module Entities
    
    def entities(url)
      res = AlchemyAPI.search(:entity_extraction, url: url)
      return Extractor::Entities.format(res)
    end
    
    def self.format(entities)
      return entities.map do |entity|
        name = entity["text"]
        type = entity["type"]
        sub_types = []
        if entity["disambiguated"]
          name = entity["disambiguated"]["name"]
          sub_types = entity["disambiguated"]["subType"] if entity["disambiguated"]["subType"]
        end
        {
          name: name,
          type: type,
          sub_types: sub_types
        }
      end
    end
    
  end
end