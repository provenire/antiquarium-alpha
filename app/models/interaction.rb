class Interaction < ActiveRecord::Base
  # Attributes:
  #  - actor
  #  - event
  #  - recipient
  #  - unknown_actor
  
  
  
  # Relationships
  belongs_to :actor, polymorphic: true
  belongs_to :event
  
  
  # Revisions
  has_paper_trail
  
  
  # Activity
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user },
          params: {
            actor_id:   Proc.new{|controller, model| model.actor.id unless model.unknown_actor },
            actor_name: Proc.new{|controller, model| model.actor.name unless model.unknown_actor },
            actor_type: Proc.new{|controller, model| model.actor.class.to_s unless model.unknown_actor },
            unknown:    Proc.new{|controller, model| model.unknown_actor },
            event_id:   Proc.new{|controller, model| model.event.id },
            event_name: Proc.new{|controller, model| model.event.name }
          }
  
  
  def get_actor
    if self.actor
      return self.actor
    else
      return Unknown.new
    end
  end
  
end
