class Person < ActiveRecord::Base
  # Attributes:
  #  - uuid
  #  - name
  #  - description
  #  - gender
  #  - date_of_birth
  #  - date_of_death
  #  - nationality
  
  
  
  # Concerns
  include UUID
  include Filterable
  
  
  
  # Relations
  has_and_belongs_to_many :photos
  
  has_many :employments
  has_many :people, through: :employments
  
  has_many :interactions, as: :actor
  has_many :events, through: :interactions
  has_many :artifacts, -> { uniq }, through: :events
  
  
  
  # Search
  include PgSearch
  multisearchable :against => [:name, :description]
  
  
  
  # Revisions
  has_paper_trail
  
  
  # Activity
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user },
          params: {
            owner_name:  Proc.new{|controller, model| controller.current_user.name },
            name:        Proc.new{|controller, model| model.name},
            description: Proc.new{|controller, model| model.description},
            thumb:       Proc.new{|controller, model| model.has_photos? ? model.default_photo_uploader.small_thumb.url : ''}
          }
  
  
  
  # Scopes
  def self.has_artifacts(yes)
    joins(:events).uniq.joins(:artifacts)
  end
  
  def self.has_photos(yes)
    includes(:photos).where.not(photos: {id: nil})
  end
  
  def self.has_employments(yes)
    includes(:employments).where.not(employments: {id: nil})
  end
  
  
  
  # Helper functions
  def num_photos
    self.photos.size
  end
  
  def default_photo
    self.photos[0] if self.photos.size > 0
  end
  
  def default_photo_uploader
    self.default_photo.image
  end
  
  def has_photos?
    self.photos.size > 0
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
