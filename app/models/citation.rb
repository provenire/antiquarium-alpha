class Citation < ActiveRecord::Base
  # Attributes
  #  - source
  #  - content
  
  
  # Relationships
  belongs_to :source
  belongs_to :event
  
  
  # Revisions
  has_paper_trail
  
  
  # Activity
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user },
          params: {
            event_id:    Proc.new{|controller, model| model.event.id },
            event_name:  Proc.new{|controller, model| model.event.name },
            source_id:   Proc.new{|controller, model| model.source.id },
            source_name: Proc.new{|controller, model| model.source.name },
            content: Proc.new{|controller, model| model.content }
          }
  
end
