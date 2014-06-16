class Person < ActiveRecord::Base
  # Attributes:
  #  - uuid
  #  - name
  #  - description
  #  - gender
  #  - date_of_birth
  #  - date_of_death
  #  - nationality
  
  
  # Generate a UUID on create
  before_create do |artifact|
    artifact.uuid = SecureRandom.uuid
  end
  
  # Proper REST routing
  def to_param
    uuid
  end
  
end
