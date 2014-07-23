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



  # Helpers
  def lat_long
    [self.latitude, self.longitude].join(",")
  end
  
  def map_url
    "http://maps.googleapis.com/maps/api/staticmap?center=#{self.lat_long}&size=300x300&maptype=hybrid&markers=size:mid%7Ccolor:red%7C#{self.lat_long}"
  end
end
