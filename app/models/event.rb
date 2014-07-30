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
  has_many :citations
  has_many :people, through: :interactions, source: :actor, source_type: 'Person'
  has_many :places, through: :interactions, source: :actor, source_type: 'Place'
  
  has_one  :location, as: :locatable
  has_and_belongs_to_many :artifacts
  
  
  
  # Revisions
  has_paper_trail
  
  
  
  # Money
  monetize :price_cents, with_model_currency: :price_currency
  
  
  
  # Helpers
  def name
    n = []
    n << "{self.year}:" if !self.year.size==0
    n << self.primary_actors.map(&:name).join(", ")
    n << self.pretty_verb
    n << self.secondary_actors.map(&:name).join(", ") if !self.location
    n << self.address if self.location
    return n.join(" ")
  end
  
  def has_citations?
    self.citations.size > 0
  end
  
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
