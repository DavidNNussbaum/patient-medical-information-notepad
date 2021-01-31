class InfoController < ApplicationController

    get '/info' do
        redirect_if_not_logged_in
        @patient = Patient.find(session["user_id"])
        @info = @patient.info
        erb :show
    end

    get '/info/new' do
        redirect_if_not_logged_in
        erb :notes/new
    end

    get '/info/:id' do
        redirect_if_not_logged_in
        @info = Info.find_by(id: params[:id])
        erb :show
    end

  
    post '/info' do
        redirect_if_not_logged_in
        redirect_error_if_not_authorized
        info = Info.create(params["info"])
        redirect '/info/#{info.id}'
    end

  
    get '/info/:id/edit' do
        redirect_if_not_logged_in
        redirect_error_if_not_authorized
        @info = Info.find_by(id: params[:id])
        erb :info/edit
    end

    patch '/info/:id' do
        redirect_if_not_logged_in
        redirect_error_if_not_authorized
        info = Info.find_by(id: params[:id])
        info.update(params["info"])
        redirect "/info/#{info.id}"
    end

    delete '/info/:id' do
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

 