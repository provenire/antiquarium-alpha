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
  
  
  def domain
    URI.parse(self.uri).host.sub(/:\/\/(www\.).+/, '')
  end
  
  def generate_pdf
    self.update_attributes(status: 'queued')
    Resque.enqueue(WebPDF, self.uuid)
  end
    
end