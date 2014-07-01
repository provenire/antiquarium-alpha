class Artifact < ActiveRecord::Base
  # Attributes:
  #  - uuid
  #  - name
  #  - alternate_names
  #  - description
  #  - artist
  #  - dimensions
  #  - date_created
  
  
  # UUID Operations
  include UUID
  
  
  # Relations
  has_and_belongs_to_many :photos
  
  
  # Helpers
  def names
    self.alternate_names || []
  end
  
  def active?
    self.published==true
  end
  
  def materials_comma_separated
    self.materials.pluck(:name).join(", ")
  end
  
  def has_events?
    self.events.size > 0
  end
  
  def num_photos
    return self.photos.size
  end
  
  def default_photo
    self.photos[0] if self.photos.size > 0
  end
  
  def next_photos
    self.photos[1..3]
  end
  
  def find_spot
    self.events.where("details ? 'location_discovered'").first || nil
  end
  
  def current_status
    self.events.order(:date).last || nil
  end
  
end
