helpers do 
  def current_user
    User.find_by(id: session[:user_id])
  end
end

# Homepage (Root path)
get '/' do
  erb :index
end

get '/signup' do 
  @user = User.new
  erb(:signup)
end

post '/signup' do
  @user = User.new(
    username: params[:username],
    email: params[:email],    
    password: params[:password],
  )
  if @user.save
    redirect(to('/'))
  else
    erb(:signup)
  end
end

post '/login' do
  username = params[:username]
  password = params[:password]

#1. find user by username
  user = User.find_by_username(username)

#2. if that user exists
  if user && user.password == password
    session[:user_id] = user.id
    redirect(to('/'))

  else
    @error_message = "Login failed."
    redirect(to('/'))
  end 
end

get '/logout' do 
  session[:user_id] = nil
  redirect(to('/'))
end


get '/songs' do 
  @songs = Song.all


  ##this allows for us to have access to @messages in the index.erb file.
  erb(:'songs/index')
end

get '/songs/new' do 
  @song = Song.new
  erb(:'songs/new')
end

post '/songs' do
  @song = Song.new(
    url: params[:url],
    title: params[:title],
    author: params[:author],
    user_id: current_user.id
    )
  if @song.save
    redirect '/songs'
  else
    erb(:'songs/new')
  end
end

get '/songs/:id' do
  @song = Song.find(params[:id])
  @upvotes = Vote.where(song_id: @song.id, upvote: true).count
  @downvotes = Vote.where(song_id: @song.id, upvote: false).count

  erb :'songs/show'
end

get '/songs/upvote/:id' do
  @vote = Vote.new(
    upvote: true,
    song_id: params[:id],
    user_id: session[:user_id]
  )

  @vote.save

  redirect '/songs/' + params[:id]
end

get '/songs/downvote/:id' do
  @vote = Vote.new(
    upvote: false,
    song_id: params[:id],
    user_id: session[:user_id]
  )

  @vote.save

  redirect '/songs/' + params[:id]
end


# post '/votes' do
#   song_id = params[:song_id]

#   vote = Vote.new(song_id: song_id, user_id: current_user.id)
#   vote.save

#   redirect(back)
# end

# delete '/votes/:id' do
#   vote = Vote.find(params[:id])
#   vote.destroy
#   redirect(back)
# end

