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

end
