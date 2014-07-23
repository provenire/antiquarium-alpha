class Interaction < ActiveRecord::Base
  # Attributes:
  #  - actor
  #  - event
  #  - recipient
  #  - unknown_actor
  
  
  
  # Relationships
  belongs_to :actor, polymorphic: true
  belongs_to :event
  
  
  def get_actor
    if self.actor
      return self.actor
    else
      return Unknown.new
    end
  end
  
end
