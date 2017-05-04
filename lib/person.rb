class Person

  attr_accessor(:name, :id)

  def initialize (attributes)
    @name = attributes.fetch(:name)
    @id = attributes[:id]
  end

  def save
    result = DB.exec("INSERT INTO person (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def Person.all
    persons =[]
    found_persons = DB.exec("SELECT * FROM person;")
    found_persons.each do |person|
      name = person['name']
      id = person['id'].to_i
      persons.push(Person.new({:name => name, :id => id}))
    end
    persons
  end

  def == (other_person)
    self.name == other_person.name && self.class == other_person.class
  end

  def Person.find (identification)
    Person.all.each do |person|
      if person.id == identification
        return person
      end
    end
  end

  def update (attributes)
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE person SET name = '#{@name}' WHERE id = #{self.id};")

    attributes.fetch(:book_ids, []).each do |book_id|
      DB.exec("INSERT INTO books_person (book_id, person_id) VALUES (#{book_id}, #{self.id});")
    end
  end

  def books
    person_books_array =[]
    results = DB.exec("SELECT book_id FROM books_person WHERE book_id = #{self.id};")
    results.each do |result|
      book_id = result.fetch('book_id').to_i
      book = DB.exec("SELECT * FROM books WHERE id = #{book_id};")
      title = book.first['title']
      person_books_array.push(Book.new({:title => title, :id => book_id}))
    end
    person_books_array
  end

  def delete
    DB.exec("DELETE FROM person WHERE id = #{self.id}")
  end

end
