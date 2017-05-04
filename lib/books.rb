
class Book

  attr_accessor :title, :author, :id, :checkout

  def initialize(attributes)
    @title = attributes[:title]
    @author = attributes[:author]
    @id = attributes[:id]
    @checkout = false
  end

  def Book.all
    books = []
    found_books = DB.exec("SELECT * FROM books;")
    found_books.each() do |book|
      title = book['title']
      author = book['author']
      id = book['id'].to_i
      checkout = book['checkout']
      books.push(Book.new({:title => title , :author => author, :id => id, :checkout => checkout}))
      end
    books
  end

  def save
    result = DB.exec("INSERT INTO books (title, author, checkout) VALUES ('#{@title}', '#{@author}', #{@checkout}) RETURNING id;")
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
    @title = attributes.fetch(:title, @title)
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{self.id};")

    attributes.fetch(:person_ids, []).each do |person_id|
      DB.exec("INSERT INTO books_person (person_id, book_id) VALUES (#{person_id}, #{self.id});")
    end
  end

  def persons
    books_persons_array = []
    results = DB.exec("SELECT person_id FROM books_person WHERE book_id = #{self.id};")
    results.each do |result|
      person_id = result.fetch('person_id').to_i
      person = DB.exec("SELECT * FROM person WHERE id = #{person_id};")
      name = person.first['name']
      books_persons_array.push(Person.new({:name => name, :id => person_id}))
    end
    books_persons_array
  end

  def delete
    DB.exec("DELETE FROM books WHERE id = #{self.id};")
  end

end
