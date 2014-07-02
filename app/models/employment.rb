class Employment < ActiveRecord::Base
  # Attributes
  #  - person
  #  - place
  #  - title
  #  - start_date
  #  - end_date
  #  - current_job
  #  - details
  
  belongs_to :person
  belongs_to :place
  
end
