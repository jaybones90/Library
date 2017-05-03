require('rspec')
require('pg')
require('books')
require('pry')

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("TRUNCATE books;")
  end
end
