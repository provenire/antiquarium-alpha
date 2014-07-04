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
  #  - google_id
  #  - isbn
  
  hstore_accessor :specifics,
    google_id: :string,
    isbn:      :string
    
  
  def external_resource
    "http://books.google.com/books?id=#{self.google_id}"
  end
    
end