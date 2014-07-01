class Place < ActiveRecord::Base
  # Attributes
  #  - uuid
  #  - name
  #  - description
  
  
  # UUID Operations
  include UUID
  
  
  # Relations
  has_and_belongs_to_many :photos
  
  
  # Helper functions
  def num_photos
    return self.photos.size
  end
  
  def default_photo
    self.photos[0] if self.photos.size > 0
  end
  
  def next_photos
    self.photos[1..3]
  end
  
  def has_employments?
    self.employments.size > 0
  end
  
  def has_artifacts?
    self.artifacts.size > 0
  end
  
end