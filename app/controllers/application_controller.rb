require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
  end

  get '/' do
    erb :index
  end

  post '/login'
    if redirect_if_not_logged_in
    else
      erb :show
    end
 end

  post '/signup'
    if current_user
      erb :show
    else
      @patient = Patient.new(params)
      erb :blank
    end
  end


  get '/error' do
    erb :error
end

  helpers do

    def current_user # memoization
        @current_user ||= Patient.find_by_id(session["user_id"]) if session["user_id"]
    end

    def logged_in?
        !!current_user
    end

    def redirect_if_not_logged_in
        redirect '/login' if !logged_in?
    end

    def redirect_if_logged_in
        redirect '/show' if logged_in?
    end


end
