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
    redirect_if_logged_in
  else
    erb :login
  end
  end

  post '/login' do
    if redirect_if_not_logged_in
    else
      @patient = Patient.find(session["patient_id"])
        @histories = History.create(:diagnoses => params[:diagnoses], :medications => params[:medications], :allergies => params[:allergies], :current_treatments => params[:current_treatments], :surgeries => params[:surgeries], :immunizations_with_dates => params[:immunizations_with_dates])
        @histories.patient_id = @patient.id
        @subjectives = Subjective.create(:location => params[:location], :observed_changes => params[:observed_changes], :sensation_changes => params[:sensation_changes], :scale_1_to_10 => params[:scale_1_to_10], :length_of_time => params[:length_of_time])
        @subjectives.patient_id = @patient.id
        @comments = Comment.create(:note => params[:note], :items_to_discuss => params[:items_to_discuss], :questions => params[:questions])
        @comments.patient_id = @patient.id
      erb :show
    end
 end

 get '/signup' do
  redirect_if_logged_in
  erb :new
end

  post '/signup' do
    patient = Patient.new(username: params["username"], password: params["password"])
        if patient.save
            session["patient_id"] = patient.id
            redirect '/blank'
        else
          redirect '/show'
    end
 end

  get '/show' do
    erb :show
  end

  delete '/logout' do
    session.delete("patient_id")
    redirect "/login"
  end

  get '/blank' do
    erb :blank
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
