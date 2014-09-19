class Website < Source
  # Source
  #  - uuid
  #  - name
  #  - description
  #  - status
  #  - thumbnail
  #  - document
  #
  # Attributes
  #  - uri
  
  hstore_accessor :specifics,
    uri: :string
  
  
  # Mount Carrierwave
  mount_uploader :document,  WebsiteUploader
    
    
  def process
    if self.status == 'new'
      self.generate_pdf
    end
  end
  
  def extract
    site = Extractor.url(self.uri)
    self.name        = site[:name]
    self.description = site[:description]
    self.remote_thumbnail_url = site[:thumbnail] if site[:thumbnail]
  end
  
  def domain
    URI.parse(self.uri).host.sub(/:\/\/(www\.).+/, '')
  end
  
  def generate_pdf
    self.update_attributes(status: 'queued')
    Resque.enqueue(WebPDF, self.uuid)
  end
  
  
  
  # Callbacks
  before_create do |website|
    website.status = 'new'
    extract
  end
    
end