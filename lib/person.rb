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

end
