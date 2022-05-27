# These lines load Sinatra and a helper tool to reload the server
# when we have changed the file.
require 'sinatra/base'
require 'sinatra/reloader'

# You will want to require your data model class here
require "database_connection"
require "animals_table"
require "animal_entity"

require "board_entry_entity"
require "board_table"
require "comment_table"
require "comment_entity"


class WebApplicationServer < Sinatra::Base
  # This line allows us to send HTTP Verbs like `DELETE` using forms
  use Rack::MethodOverride

  configure :development do
    # In development mode (which you will be running) this enables the tool
    # to reload the server when your code changes
    register Sinatra::Reloader

    # In development mode, connect to the development database
    db = DatabaseConnection.new("localhost", "web_application_dev")
    $global = { db: db }
  end

  configure :test do
    # In test mode, connect to the test database
    db = DatabaseConnection.new("localhost", "web_application_test")
    $global = { db: db }
  end

  def animals_table
    $global[:animals_table] ||= AnimalsTable.new($global[:db])
  end

  def comment_table
    $global[:comment_table] ||= CommentList.new($global[:db])
  end

  def board
    $global[:board] ||= BoardTable.new($global[:db], comment_table)
  end

  # Start your server using `rackup`.
  # It will sit there waiting for requests. It isn't broken!

  # YOUR CODE GOES BELOW THIS LINE

  get '/board' do
    board_entries = board.list
    # p board_entries
    erb :board_entry_index, locals: {
      board_entries: board_entries
    }
  end

  get '/board/new'do
    erb :board_new
  end

  post '/board' do
    entry = BoardEntryEntity.new(params[:number], params[:description])
    board.add(entry)
    redirect '/board'
  end

  delete '/board/:index' do
    board.remove(params[:index].to_i)
    redirect '/board'
  end

  get '/board/:index/edit' do
    board_entry_index = params[:index].to_i
    erb :board_edit, locals: {
      index: board_entry_index,
      board_entry_entity: board.get(board_entry_index)
    }
  end

  patch '/board/:index' do
    board_entry_index = params[:index].to_i
    board.update(board_entry_index, params[:number],params[:description])
    redirect '/board'
  end
  
#### in progress

  #### EXAMPLE ROUTES
#   ' ' '
#
#
#
#


  get '/animals' do
    erb :animals_index, locals: { animals: animals_table.list }
  end

  get '/animals/new' do
    erb :animals_new
  end

  post '/animals' do
    animal = AnimalEntity.new(params[:species])
    animals_table.add(animal)
    redirect '/animals'
  end

  delete '/animals/:index' do
    animals_table.remove(params[:index].to_i)
    redirect '/animals'
  end

  get '/animals/:index/edit' do
    animal_index = params[:index].to_i
    erb :animals_edit, locals: {
      index: animal_index,
      animal: animals_table.get(animal_index)
    }
  end

  patch '/animals/:index' do
    animal_index = params[:index].to_i
    animals_table.update(animal_index, params[:species])
    redirect '/animals'
  end
end
