class Event < ActiveRecord::Base
  # Attributes
  #  - uuid
  #  - date
  #  - verb
  #  - details
  #  - failed
  #  - price
  #  - location
  
  
  
  # UUID Operations
  include UUID
  
  
  
  # Relationships
  has_many :interactions
  has_one  :location, as: :locatable
  has_and_belongs_to_many :artifacts
  
  
  
  # Money
  monetize :price_cents, with_model_currency: :price_currency
  
  
end
