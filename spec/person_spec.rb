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
end
