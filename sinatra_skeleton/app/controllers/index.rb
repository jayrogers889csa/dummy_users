require 'pry'
require 'pry-nav'

enable :sessions

get '/' do
  session[:message]

  erb :index
end

post '/create_account' do
  @fullname = params[:post][:fullname]
  @email = params[:post][:email]
  @password = params[:post][:password]

  User.create(params[:post])

  user = User.authenticate(@email, @password)

  if user
    session[:id] = user.id

    erb :user_successfully_created_and_logged_in
  end
end

get '/log_in' do

  erb :log_in
end

post "/verify_account" do

  @email = params[:post][:email]
  @password = params[:post][:password]

  user = User.authenticate(@email, @password)

  if user
    session[:id] = user.id
    # binding.pry
    erb :user_successfully_authenticated
  else
    erb :log_in
  end
end


get '/create_new_account' do
  # Look in app/views/index.erb
  erb :create_new_account
end

get '/view_secret_file' do

  # binding.pry

  if session[:id]
    erb :show_the_secrets
  else
    erb :log_in
  end

end

get '/log_out' do

  session.clear

  erb :successfully_logged_out
end
