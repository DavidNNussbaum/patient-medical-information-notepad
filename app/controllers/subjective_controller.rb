class SubjectiveController < ApplicationController

    post '/subjectives' do
        @subjectives = Subjectives.new(params)
        @subjectives.patient_id = @patient.id
        erb :show
    end

    get '/info' do
        redirect_if_not_logged_in
        @patient = Patient.find(session["user_id"])
        @histories = History.find(patient_id == @patient.id)
        @subjectives = Subjective.find(patient_id == @patient.id)
        @comments = Comment.find(patient_id == @patient.id)
        erb :blank
    end

    get '/info/new' do
        @patient = Patient.find(session["user_id"])
        redirect_if_not_logged_in
        erb :notes/new
    end

    get '/info/:id' do
        @patient = Patient.find(session["user_id"])
        redirect_if_not_logged_in
        @info = Info.find_by(id: params[:id])
        erb :show
    end

  
    post '/info' do
        redirect_if_not_logged_in
        redirect_error_if_not_authorized
        # patient = Patient.username(params["username"])
        @patient = Patient.find(session["user_id"])
        info = Info.create(params["info"])
        redirect '/show/#{patient}'
    end

  
    get '/info/:id/edit' do
        @patient = Patient.find(session["user_id"])
        redirect_if_not_logged_in
        redirect_error_if_not_authorized
        @info = Info.find_by(id: params[:id])
        erb :info/edit
    end

    patch '/info/:id' do
        @patient = Patient.find(session["user_id"])
        redirect_if_not_logged_in
        redirect_error_if_not_authorized
        info = Info.find_by(id: params[:id])
        info.update(params["info"])
        redirect "/info/#{info.id}"
    end

    delete '/info/:id' do
        @patient = Patient.find(session["user_id"])
        redirect_if_not_logged_in
        redirect_error_if_not_authorized
        info = Info.find_by(id: params[:id])
        info.delete
        redirect "/info"
    end

    private

    def redirect_error_if_not_authorized
        redirect "/error"
    end
end