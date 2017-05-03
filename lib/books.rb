
class Book

  attr_accessor :title, :author, :id

  def initialize(attributes)
    @title = attributes[:title]
    @author = attributes[:author]
  end

  def Book.all
    books = []
    found_books = DB.exec("SELECT * FROM books;")
    found_books.each() do |book|
      title = book.fetch('title')
      author = book.fetch('author')
      books.push(Book.new({:title => title , :author => author}))
      end
    books
  end

  def save
    result = DB.exec("INSERT INTO books (title, author) VALUES ('#{@title}', '#{@author}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def ==(another_book)
    self.title == another_book.title && self.author == another_book.author
  end

  def Book.find(identification)
    found_book = nil
    Book.all.each do |book|
      if book.id == indentification
        found_book = book
      end
    end
    found_book
  end    
end
