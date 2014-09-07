module Extractor
  module URL
    
    def url(url, raw = false)
      res = @embedly.extract(url: url)[0].marshal_dump
      if raw == true
        return res
      else
        return Extractor::URL.format(res)
      end
    end
    
    def self.format(site)
      {
        name:        site[:title],
        description: site[:description],
        thumbnail:   Extractor::URL.thumbnail(site[:images]),
        uri:         site[:url]
      }
    end
    
    def self.thumbnail(images)
      if images && images.size > 0
        images.sort{|a,b| (b["width"].to_i*b["height"].to_i) <=> (a["width"].to_i*a["height"].to_i) }[0]["url"]
      else
        nil
      end
    end
    
  end
end