class Artifact < ActiveRecord::Base
  # Attributes:
  #  - uuid
  #  - name
  #  - alternate_names
  #  - description
  #  - artist
  #  - dimensions
  #  - date_created
  
  
  
  # Generate a UUID on create
  before_create do |artifact|
    artifact.uuid = SecureRandom.uuid
  end
  
  # Proper REST routing
  def to_param
    uuid
  end
  
end
