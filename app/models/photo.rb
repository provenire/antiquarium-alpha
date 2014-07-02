class Photo < ActiveRecord::Base
  # Attributes
  #  - image
  #  - comments
  
  
  
  # Mount Carrierwave
  mount_uploader :image, ImageUploader
  
  
  
  # Relations
  has_and_belongs_to_many :artifacts
  has_and_belongs_to_many :people
  
  
  
  # Helper Functions
  def objects
    self.artifacts.to_a + self.places.to_a + self.people.to_a
  end
  
  def has_artifacts?
    self.artifacts.size > 0
  end
  
  def has_places?
    self.places.size > 0
  end
  
  def has_people?
    self.people.size > 0
  end
  
  def is_lonely?
    !self.has_artifacts? && !self.has_places? && !self.has_people?
  end
  
end
