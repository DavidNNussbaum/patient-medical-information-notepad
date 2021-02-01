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
      @patient = Patient.find(session["user_id"])
      @histories = History.new(params)
      @histories.patient_id = @patient.id
      @subjectives = Subjective.new(params)
      @subjectives.patient_id = @patient.id
      @comments = Comment.new(params)
      @comments.patient_id = @patient.id
      erb :show
    end
 end

  post '/signup'
    if current_user
      @patient = Patient.find(session["user_id"])
      @histories = History.new(params)
      @histories.patient_id = @patient.id
      @subjectives = Subjective.new(params)
      @subjectives.patient_id = @patient.id
      @comments = Comment.new(params)
      @comments.patient_id = @patient.id
      erb :show
    else
      @patient = Patient.new(params)
      erb :blank
    end
  end

  get '/error' do
    erb :error

  delete '/logout' do
    session.delete("patient_id")
    redirect "/login"
  end
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
