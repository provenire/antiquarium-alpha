class Employment < ActiveRecord::Base
  # Attributes
  #  - person
  #  - place
  #  - title
  #  - start_date
  #  - end_date
  #  - current_job
  #  - details
  
  
  
  # Relationships
  belongs_to :person
  belongs_to :place
  
  
  # Revisions
  has_paper_trail
  
  
  # Helpers
  def name
    "#{self.person.name} @ #{self.place.name}"
  end
  
end
