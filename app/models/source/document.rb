class Document < Source
  # Source
  #  - uuid
  #  - name
  #  - description
  #  - status
  #  - thumbnail
  #  - document
  
  # hstore_accessor :specifics
  
  # Mount Carrierwave
  mount_uploader :document,  DocumentUploader
  
  def process
    # do nothing
  end
    
end