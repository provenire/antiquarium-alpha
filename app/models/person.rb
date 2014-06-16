class Person < ActiveRecord::Base
  # Attributes:
  #  - uuid
  #  - name
  #  - description
  #  - gender
  #  - date_of_birth
  #  - date_of_death
  #  - nationality
  
  
  # Relations
  has_and_belongs_to_many :photos
  
  
  # Helper functions
  def num_photos
    self.photos.size
  end
  
  def default_photo
    self.photos[0] if self.photos.size > 0
  end
  
  def next_photos
    self.photos[1..3]
  end
  
  def age
    if self.date_of_birth && self.date_of_death
      return self.date_of_death.year - self.date_of_birth.year
    elsif self.date_of_birth
      return Date.today.year - self.date_of_birth.year
    else
      return 'Unknown'
    end
  end
  
  def has_employments?
    self.employments.size > 0
  end
  
  def has_artifacts?
    self.artifacts.size > 0
  end
  
  
  # Generate a UUID on create
  before_create do |person|
    person.uuid = SecureRandom.uuid
  end
  
  # Proper REST routing
  def to_param
    uuid
  end
  
end
