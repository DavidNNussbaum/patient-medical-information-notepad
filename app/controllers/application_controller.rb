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

  get '/login' do
    erb :blank
  end

  post '/login' do
    if redirect_if_not_logged_in
    else
      @patient = Patient.find(session["patient_id"])
      @histories = History.create(params[:diagnoses, :medications, :allergies, :current_treatments, :surgeries, :immunizations_with_dates])
      @histories.patient_id = @patient.id
      @subjectives = Subjective.create(params[:location, :observed_changes, :sensation_changes, :scale_1_to_10, :length_of_time])
      @subjectives.patient_id = @patient.id
      @comments = Comment.create(params[:note, :items_to_discuss, :questions])
      @comments.patient_id = @patient.id
      erb :show
    end
 end

  post '/signup' do
    # Patient.all.each do |patient|
    #   if patient('params') == @current_user('params')
    patient = Patient.new(username: params["username"], password: params["password"])
        # validate email, validate password, email not in database
        if patient.save
            session["patient_id"] = patient.id
            redirect '/login'
        else
         @patient = Patient.create(params)
         @name = @patient.username
      erb :blank
    end
 end

  delete '/logout' do
    session.delete("patient_id")
    redirect "/login"
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
