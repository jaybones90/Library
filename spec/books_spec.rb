require('spec_helper')

describe(Book) do
  describe('#title') do
    it('returns the title of the book') do
      test_book = Book.new({:title => 'The Hatchet', :author => 'Gary Paulsen'})
      expect(test_book.title).to(eq('The Hatchet'))
    end
  end

  describe('#author') do
    it('returns the author of the book') do
      test_book = Book.new({:title => 'The Hatchet', :author => 'Gary Paulsen'})
      expect(test_book.author).to(eq("Gary Paulsen"))
    end
  end

  describe('#checkout') do
    it('returns the status on if the book is checked out') do
      test_book = Book.new({:title => 'The Hatchet', :author => 'Gary Paulsen'})
      expect(test_book.checkout).to(eq(false))
    end
  end

  describe('.all') do
    it('returns all the books but starts out empty') do
      expect(Book.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves each instance of book to the database') do
      test_book = Book.new({:title => 'The Hatchet', :author => 'Gary Paulsen'})
      test_book.save
      expect(Book.all).to(eq([test_book]))
    end
  end

  describe('#==') do
    it('compares the author and name and returns true if they are the same') do
      test_book1 = Book.new({:title => 'The Hatchet', :author => 'Gary Paulsen'})
      test_book2 = Book.new({:title => 'The Hatchet', :author => 'Gary Paulsen'})
      expect(test_book1 == test_book2).to(eq(true))
    end
  end

  describe("#id") do
    it('get the id of a book ') do
      test_book = Book.new({:title => 'The Hatchet', :author => 'Gary Paulsen'})
      test_book.save
      expect(test_book.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe(".find") do
    it("finds a book based off an id") do
      test_book = Book.new({:title => 'The Hatchet', :author => 'Gary Paulsen'})
      test_book.save
      test_book2 = Book.new({:title => 'The Hatchet2', :author => 'Gary Paulsen2'})
      test_book2.save
      expect(Book.find(test_book.id)).to(eq(test_book))
    end
  end
  describe(".find_by_author") do
    it("finds a book based off an author") do
      test_book = Book.new({:title => 'The Hatchet', :author => 'Gary Paulsen'})
      test_book.save
      test_book2 = Book.new({:title => 'The Hatchet2', :author => 'Gary Paulsen2'})
      test_book2.save
      expect(Book.find_by_author(test_book.author)).to(eq(test_book))
    end
  end
  describe(".find_by_title") do
    it("finds a book based off an title") do
      test_book = Book.new({:title => 'The Hatchet', :author => 'Gary Paulsen'})
      test_book.save
      test_book2 = Book.new({:title => 'The Hatchet2', :author => 'Gary Paulsen2'})
      test_book2.save
      expect(Book.find_by_title(test_book.title)).to(eq(test_book))
    end
  end

  describe("#update") do
    it("will update a book title and author") do
      test_book = Book.new({:title => 'The Hatchet', :author => 'Gary Paulsen'})
      test_book.save
      randy = Person.new({:name => "Macho Man Randy Savage"})
      randy.save
      jimbo = Person.new({:name => "Jimbo Jones"})
      jimbo.save
      test_book.update({:person_ids => [randy.id , jimbo.id]})
      expect(test_book.persons).to(eq([randy, jimbo]))
    end
  end

  describe("#persons") do
    it("will return all people associated with a book") do
      test_book = Book.new({:title => 'The Hatchet', :author => 'Gary Paulsen'})
      test_book.save
      randy = Person.new({:name => "Macho Man Randy Savage"})
      randy.save
      jimbo = Person.new({:name => "Jimbo Jones"})
      jimbo.save
      test_book.update({:person_ids => [randy.id , jimbo.id]})
      expect(test_book.persons).to(eq([randy, jimbo]))
    end
  end

  describe("#delete") do
    it("will delete a book") do
      test_book = Book.new({:title => 'The Hatchet', :author => 'Gary Paulsen'})
      test_book.save
      test_book2 = Book.new({:title => 'Fear and Loathing in Las Vegas', :author => 'Hunter S. Thompson'})
      test_book2.save
      test_book.delete
      expect(Book.all).to(eq([test_book2]))
    end
  end

end
