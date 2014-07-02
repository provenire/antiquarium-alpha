class Event < ActiveRecord::Base
  # Attributes
  #  - uuid
  #  - date
  #  - verb
  #  - details
  #  - failed
  #  - price
  
  
  
  # Relationships
  has_many :interactions
  
  
end
