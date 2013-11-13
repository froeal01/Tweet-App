get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)



  session[:oauth_token] = @access_token.token
  session[:oauth_secret] = @access_token.secret
  


  if User.find_by_oauth_token(session[:oauth_token])
    redirect to ('/welcome')
    puts "here"
  else
    User.create(:username => @access_token.params[:screen_name], :oauth_token => @access_token.token, :oauth_secret => @access_token.secret )
    redirect to ('/welcome')
  end 
end


get '/welcome' do

  @user=User.find_by_oauth_token(session[:oauth_token])
  # TwitterOauthSetting.create(session[:oauth_token],session[:oauth_secret], user_id: @user.id)


  erb :main_page
end

post '/welcome' do
    tweet = params[:tweet_area]
      @user=User.find_by_oauth_token(session[:oauth_token])
      job_id =@user.tweet_future(4.minutes,tweet)
      if request.xhr?
   "/status/#{job_id}"
      end
 end


