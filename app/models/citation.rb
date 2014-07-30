class Citation < ActiveRecord::Base
  # Attributes
  #  - source
  #  - content
  
  
  # Relationships
  belongs_to :source
  belongs_to :event
  
end
