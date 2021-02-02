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
    if redirect_if_logged_in
    else
    @patient = Patient.find(session["patient_id"])
    erb :show
    end
  end
  

  post '/login' do
    patient = Patient.find_by_username(params["username"])
    if patient.authenticate(params["password"])
        session["patient_id"] = patient.id
        redirect "/show"
    else
        "Invalid login"
        sleep 1
        redirect "/login"
    end
  end
    
  get '/relogin' do
      erb :login
  end
    # if redirect_if_not_logged_in
    # else
    #    @patient = Patient.find(session["patient_id"])
    #     @histories = History.create(:diagnoses => params[:diagnoses], :medications => params[:medications], :allergies => params[:allergies], :current_treatments => params[:current_treatments], :surgeries => params[:surgeries], :immunizations_with_dates => params[:immunizations_with_dates])
    #     @histories.patient_id = @patient.id
    #     @subjectives = Subjective.create(:location => params[:location], :observed_changes => params[:observed_changes], :sensation_changes => params[:sensation_changes], :scale_1_to_10 => params[:scale_1_to_10], :length_of_time => params[:length_of_time])
    #     @subjectives.patient_id = @patient.id
    #     @comments = Comment.create(:note => params[:note], :items_to_discuss => params[:items_to_discuss], :questions => params[:questions])
    #     @comments.patient_id = @patient.id
    #   erb :show
    # end


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
    @patient = Patient.find(session["patient_id"])
    @histories = History.create(:diagnoses => params[:diagnoses], :medications => params[:medications], :allergies => params[:allergies], :current_treatments => params[:current_treatments], :surgeries => params[:surgeries], :immunizations_with_dates => params[:immunizations_with_dates])
    @histories.patient_id = @patient.id
    @subjectives = Subjective.create(:location => params[:location], :observed_changes => params[:observed_changes], :sensation_changes => params[:sensation_changes], :scale_1_to_10 => params[:scale_1_to_10], :length_of_time => params[:length_of_time])
    @subjectives.patient_id = @patient.id
    @comments = Comment.create(:note => params[:note], :items_to_discuss => params[:items_to_discuss], :questions => params[:questions])
    @comments.patient_id = @patient.id
    erb :show
  end

  delete '/logout' do
    session.delete("patient_id")
    redirect "/relogin"
  end

  get '/relogin' do
    erb :login
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
