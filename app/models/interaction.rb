class Interaction < ActiveRecord::Base
  # Attributes:
  #  - actor
  #  - event
  #  - recipient
  #  - unknown_actor
  
  
  
  # Relationships
  belongs_to :actor, polymorphic: true
  belongs_to :event
  
end
