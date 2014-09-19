class Book < Source
  # Source
  #  - uuid
  #  - name
  #  - description
  #  - status
  #  - thumbnail
  #  - document
  #
  # Attributes
  #  - authors
  #  - google_id
  #  - isbn
  
  hstore_accessor :specifics,
    authors:   :string,
    google_id: :string,
    isbn:      :string
    
    
    
  # Mount Carrierwave
  mount_uploader :document,  DocumentUploader
    
  
  
  # Search
  include PgSearch
  multisearchable :against => [:name, :description, :authors]
    
    
    
  def process
    # nothing
  end
  
  def extract
    book = Extractor.book(self.google_id)
    self.name        = book[:name]
    self.description = book[:description]
    self.authors     = book[:authors]
    self.isbn        = book[:isbn]
    self.remote_thumbnail_url = book[:thumbnail] if book[:thumbnail]
  end
  
  def external_resource
    "http://books.google.com/books?id=#{self.google_id}"
  end
  
  def searchable
    {
      id:          self.google_id,
      name:        self.name,
      description: self.description,
      thumbnail:   self.thumbnail.url,
      authors:     self.authors,
      isbn:        self.isbn
    }
  end
  
  
  # Callbacks
  before_create do |book|
    extract
  end
  
end