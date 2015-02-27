require "sinatra"
require "pry"
require 'pg'

def db_connection
  begin
    connection = PG.connect(dbname: "grocery_list")
    yield(connection)
  ensure
    connection.close
  end
end

def get_groceries
  db_connection do |conn|
    conn.exec('SELECT * FROM groceries')
  end
end

def add_item(item)
  db_connection do |conn|
    conn.exec_params('INSERT into groceries (item) VALUES ($1)', [item])
  end
end

get '/' do 
  redirect '/groceries'
end

get '/groceries' do
  grocery = get_groceries

  erb :index, locals: {grocery: grocery, item: "item"}
end

post '/groceries' do

  add_item(params["item"])
  redirect '/groceries'
end