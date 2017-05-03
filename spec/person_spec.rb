require('spec_helper')

describe(Person) do
  describe('#name') do
    it('returns the name of the person') do
      test_person = Person.new({:name => 'Jason'})
      expect(test_person.name).to(eq('Jason'))
    end
  end
end
