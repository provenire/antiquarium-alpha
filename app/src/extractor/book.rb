module Extractor
  module Book
    
    def book(id)
      return Extractor::Book.format(GoogleBooks.search(id).first)
    end
    
    def self.search(query)
      results = GoogleBooks.search(query)
      return results.map{|book| Extractor::Book.format(book) }
    end
    
    def self.format(book)
      {
        id:          book.id,
        name:        book.title,
        description: book.description,
        thumbnail:   book.image_link,
        authors:     book.authors,
        isbn:        book.isbn
      }
    end
    
  end
end