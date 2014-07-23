class Event < ActiveRecord::Base
  # Attributes
  #  - uuid
  #  - date
  #  - verb
  #  - details
  #  - failed
  #  - price
  #  - location
  
  
  
  # UUID Operations
  include UUID
  
  
  
  # Relationships
  has_many :interactions
  has_many :people, through: :interactions, source: :actor, source_type: 'Person'
  has_many :places, through: :interactions, source: :actor, source_type: 'Place'
  
  has_one  :location, as: :locatable
  has_and_belongs_to_many :artifacts
  
  
  
  # Money
  monetize :price_cents, with_model_currency: :price_currency
  
  
  
  # Helpers
  def year
    self.date.try(:year) || ""
  end
  
  def components
    Verb.find_by_keyword(self.verb).components
  end
  
  def pretty_verb
    Verb.find_by_keyword(self.verb).display
  end
  
  def primary_actors
    self.interactions.includes(:actor).where(recipient: false).map(&:get_actor)
  end
  
  def secondary_actors
    self.interactions.includes(:actor).where(recipient: true).map(&:get_actor)
  end
  
  def address
    if self.location
      return self.location.address
    else
      return "Unknown"
    end
  end
  
end
