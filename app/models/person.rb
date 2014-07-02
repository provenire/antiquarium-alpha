class Person < ActiveRecord::Base
  # Attributes:
  #  - uuid
  #  - name
  #  - description
  #  - gender
  #  - date_of_birth
  #  - date_of_death
  #  - nationality
  
  
  
  # UUID Operations
  include UUID
  
  
  
  # Relations
  has_and_belongs_to_many :photos
  
  has_many :employments
  has_many :people, through: :employments
  
  has_many :interactions, as: :actor
  has_many :events, through: :interactions
  
  
  
  # Search
  include PgSearch
  multisearchable :against => [:name, :description]
  
  
  
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
  
end
