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

end
