class Location < ActiveRecord::Base
  # Attributes:
  #  - latitude
  #  - longitude
  #  - address
  
  
  # Geocoding
  geocoded_by      :address
  after_validation :geocode
  
  
  # Relationships
  belongs_to :locatable, polymorphic: true
  
end
