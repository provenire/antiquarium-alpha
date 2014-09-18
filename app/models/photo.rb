class Photo < ActiveRecord::Base
  # Attributes
  #  - image
  #  - comments
  
  
  
  # Mount Carrierwave
  mount_uploader :image, ImageUploader
  
  
  
  # Relations
  has_and_belongs_to_many :artifacts
  has_and_belongs_to_many :people
  has_and_belongs_to_many :places
  
  
  
  # Revisions
  has_paper_trail
  
  
  # Activity
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user },
          params: {
            image: Proc.new{ |controller, model| model.image.object_main.url }
          }
  
  
  
  # Helper Functions
  def name
    "Photo #{self.id}"
  end
  
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
