
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



end
