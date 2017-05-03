require('rspec')
require('pg')
require('books')
require('person')
require('pry')

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("TRUNCATE books, person;")
  end
end
