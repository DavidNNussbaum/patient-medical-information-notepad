class PatientController < ApplicationController
    
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
            redirect '/signup'
        end
    end

    get '/blank' do
        erb :blank
    end

    get '/login' do
        redirect_if_logged_in
        erb :login
    end

    post '/login' do
        patient = Patient.username(params["username"])
        if patient.authenticate(params["username"])
            session["user_id"] = user.id
            redirect '/show'
        else
            "Invalid login"
            sleep 1
            redirect '/login'
        end
    end

    delete '/logout' do
        session.delete("user_id")
        redirect '/login'
    end

    get '/show' do
        erb :show
    end
end