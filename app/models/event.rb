class Event < ActiveRecord::Base
  # Attributes
  #  - uuid
  #  - date
  #  - verb
  #  - details
  #  - failed
  #  - price
  
  
  
  # UUID Operations
  include UUID
  
  
  
  # Relationships
  has_many :interactions
  
  
end
