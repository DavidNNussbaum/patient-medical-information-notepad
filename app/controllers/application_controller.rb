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

  post '/login' do
    patient = Patient.find_by_username(params["username"])
     if patient.authenticate(params["password"])
         session["patient_id"] = patient.id
        redirect '/show'
        else
            redirect '/login'
        end
    
  end
    
  get '/relogin' do
      erb :login
  end
    
 

  post '/signup' do
    patient = Patient.new(username: params["username"], password: params["password"])
        if patient.save
            session["patient_id"] = patient.id
            redirect '/new'
        else
          redirect '/show'
    end
 end


  delete '/logout' do
    session.delete("patient_id")
    redirect "/relogin"
  end


  get '/new' do
    erb :new
  end
 

  helpers do

    def current_user # memoization
        @current_user ||= Patient.find_by_id(session["patient_id"]) if session["patient_id"]
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
end

 
