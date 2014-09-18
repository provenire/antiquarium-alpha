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
  
  
  # Activity
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user },
          params: {
            person_id:   Proc.new{|controller, model| model.person.id },
            person_name: Proc.new{|controller, model| model.person.name },
            place_id:    Proc.new{|controller, model| model.place.id },
            place_name:  Proc.new{|controller, model| model.place.name },
            title:       Proc.new{|controller, model| model.title },
            dates:       Proc.new{|controller, model| model.dates },
            details:     Proc.new{|controller, model| model.details }
          }
  
  
  # Helpers
  def name
    "#{self.person.name} at #{self.place.name}"
  end
  
  def dates
    started = self.start_date ? self.start_date.to_s : 'unknown'
    ended   = self.end_date   ? self.end_date.to_s   : (self.current_job ? 'present' : 'unknown')
    [started, ended].join(' to ')
  end
  
end
