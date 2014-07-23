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
  has_one  :location
  has_and_belongs_to_many :artifacts
  
  
end
