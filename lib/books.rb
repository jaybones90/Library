
class Book

  attr_accessor :title, :author, :id

  def initialize(attributes)
    @title = attributes[:title]
    @author = attributes[:author]
    @id = attributes[:id]
  end

  def Book.all
    books = []
    found_books = DB.exec("SELECT * FROM books;")
    found_books.each() do |book|
      title = book['title']
      author = book['author']
      id = book['id'].to_i
      books.push(Book.new({:title => title , :author => author, :id => id}))
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

  define_singleton_method(:find) do |identification|
    Book.all.each do |book|
      if book.id == identification
        return book
      end
    end
  end

  define_singleton_method(:find_by_author) do |author|
    Book.all.each do |book|
      if book.author == author
        return book
      end
    end
  end
  define_singleton_method(:find_by_title) do |title|
    Book.all.each do |book|
      if book.title == title
        return book
      end
    end
  end

  def update (attributes)
    @title = attributes[:title]
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{self.id};")
  end

  def delete
    DB.exec("DELETE FROM books WHERE id = #{self.id};")
  end

end
