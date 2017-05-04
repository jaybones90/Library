require 'sinatra'
require 'sinatra/reloader'
require './lib/books'
require './lib/person'
require 'pry'
require 'pg'
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'library'})

get('/') do
  @persons = Person.all
  @books = Book.all
  erb(:index)
end

get('/book/new') do
  @books = Book.all
  erb(:books)
end

post('/book/new') do
  title = params.fetch("title")
  author = params.fetch("author")
  attributes = {:title => title, :author => author}
  Book.new(attributes).save
  @persons = Person.all
  @books = Book.all
  erb(:books)
end

get('/person/new') do
  @persons = Person.all
  erb(:persons)
end

post('/person/new') do
  name = params.fetch('name')
  @person = Person.new({:name => name}).save
  @persons = Person.all
  erb(:persons)
end


get('/book/:id') do
  @book = Book.find(params.fetch("id").to_i)
  @persons = Person.all
  erb(:book_info)
end

get('/person/:id') do
  @person = Person.find(params.fetch('id').to_i)
  @books = Book.all
  @books.each do |book|
    @book = book
  end
  erb(:person_info)
end
