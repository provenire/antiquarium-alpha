class WorkflowsController < ApplicationController
  
  def website
  end
  
  def extract
    site = Extractor.url(params[:url], true)
    entities = Extractor.entities(params[:url])
    matched = []
    entities.each do |e|
      matches = PgSearch.multisearch(e.name).where(searchable_type: ['Person','Place','Artifact'])
      if matches.size > 0
        matches.map! do |m|
          base = { 
            uuid: m.searchable.uuid,
            name: m.searchable.name,
            kind: m.searchable.class.to_s
          }
          base[:photo] = m.searchable.default_photo.image.object_thumb.url if (m.searchable.num_photos > 0)
          base
        end
        matched << {
          entity: e,
          matches: base
        }
      end
    end
    
    render json: results
  end
  
end