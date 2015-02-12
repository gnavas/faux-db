require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require "better_errors"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

# this will store your users
users = []

# this will store an id to user for your users
# you'll need to increment it every time you add
# a new user, but don't decrement it
id = 0

# routes to implement:
#
# GET / - show all users
get '/' do
  @users = users
  erb :index
end



# GET /users/new - display a form for making a new user
get'/users/new' do
erb :new
end
# POST /users - create a user based on params from form
post '/users' do
  id += 1
  users.push({first:params[:first],last:params[:last],id:id})
  @users = users
  erb :user_list
end

get '/users' do 
  @users = users
  erb :user_list
end
# GET /users/:id - show a user's info by their id, this should display the info in a form
get '/users/:id' do
  # "#{params[:id]}"
  user_to_pull = users.detect {|user|(user[:id].to_i)==(params[:id].to_i)}
  @users = users
  user = user_to_pull 
  @user=user
  erb :show_user
end
#
# PUT /users/:id - update a user's info based on the form from GET /users/:id
#
# DELETE /users/:id - delete a user by their id
