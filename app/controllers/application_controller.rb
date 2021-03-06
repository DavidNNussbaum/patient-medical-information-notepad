require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
    register Sinatra::Flash
  end

  get '/' do
     erb :'/sessions/index'
  end

  helpers do

    def current_user  
        @current_user ||= Patient.find_by_id(session["patient_id"]) if session["patient_id"]
    end

    def logged_in?
        !!current_user
    end
 
    def redirect_if_not_logged_in
        redirect '/login' if !logged_in?
    end

    def redirect_if_logged_in
        redirect '/' if logged_in?
    end
  end
end

 
