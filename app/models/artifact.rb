class Artifact < ActiveRecord::Base
  # Attributes:
  #  - uuid
  #  - name
  #  - alternate_names
  #  - description
  #  - artist
  #  - dimensions
  #  - date_created
  
  
  # Relations
  has_and_belongs_to_many :photos
  
  
  
  # Generate a UUID on create
  before_create do |artifact|
    artifact.uuid = SecureRandom.uuid
  end
  
  # Proper REST routing
  def to_param
    uuid
  end
  
end
