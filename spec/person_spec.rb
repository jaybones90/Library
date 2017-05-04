require('spec_helper')

describe(Person) do
  describe('#name') do
    it('returns the name of the person') do
      test_person = Person.new({:name => 'Jason'})
      expect(test_person.name).to(eq('Jason'))
    end
  end

  describe('.all') do
    it('returns all people but starts out empty') do
      expect(Person.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves the person to a database') do
      test_person = Person.new({:name => "Jason"})
      test_person.save
      expect(Person.all).to(eq([test_person]))
    end
  end

  describe('#==') do
    it('compares the name  and classand returns if they are the same') do
    test_person = Person.new({:name => "Jason"})
    test_person2 = Person.new({:name => "Jason"})
    expect(test_person == test_person2).to(eq(true))
    end
  end

  describe('#id') do
    it('returns the id of a person') do
      test_person = Person.new({:name => "Jason"})
      test_person.save
      expect(test_person.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.find') do
    it('finds a person by its id') do
      test_person = Person.new({:name => "Jason"})
      test_person.save
      test_person2 = Person.new({:name => "James"})
      test_person2.save
      expect(Person.find(test_person2.id)).to(eq(test_person2))
    end
  end

  describe("#update") do
    it("let you add a book to a person") do
      jason = Person.new({:name => "Jason"})
      jason.save
      test_book = Book.new({:title => 'The Hatchet', :author => 'Gary Paulsen'})
      test_book.save
      test_book2 = Book.new({:title => 'Fear and Loathing in Las Vegas', :author => 'Hunter S. Thompson'})
      test_book2.save
      jason.update({:book_ids => [test_book.id, test_book2.id]})
      expect(jason.books).to(eq([test_book, test_book2]))
    end
  end

  describe("#books") do
    it("will return all the books associated with the person") do
      jason = Person.new({:name => "Jason"})
      jason.save
      test_book = Book.new({:title => 'The Hatchet', :author => 'Gary Paulsen'})
      test_book.save
      test_book2 = Book.new({:title => 'Fear and Loathing in Las Vegas', :author => 'Hunter S. Thompson'})
      test_book2.save
      jason.update({:book_ids => [test_book.id, test_book2.id]})
      expect(jason.books).to(eq([test_book, test_book2]))
    end
  end

  describe("#delete") do
    it("will delete a person") do
      test_person = Person.new({:name => "Jason"})
      test_person.save
      test_person2 = Person.new({:name => "James"})
      test_person2.save
      test_person.delete
      expect(Person.all).to(eq([test_person2]))
    end
  end

end
