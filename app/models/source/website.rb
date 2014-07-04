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
    
end