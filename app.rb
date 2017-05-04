require 'sinatra'
require 'sinatra/reloader'
require './lib/books'
require './lib/person'
require 'pry'
require 'pg'
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'library'})

get('/') do
  erb(:index)
end

get('/book/new') do
  erb(:add_book_form)
end

post('/book/new') do
  title = params.fetch("title")
  author = params.fetch("author")
  attributes = {:title => title, :author => author}
  book = Book.new(attributes).save
  @books = Book.all
  erb(:index)
end

get('/books') do
  @books = Book.all
  erb(:books)
end

get('/book/:id') do
  @book = Book.find(params.fetch("id").to_i)
  erb(:book)
end
