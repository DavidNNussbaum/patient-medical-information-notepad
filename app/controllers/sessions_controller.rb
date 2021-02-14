class SessionsController < ApplicationController

    post '/login' do
        patient = Patient.find_by_username(params["username"])
        if patient.authenticate(params["password"]) && Subjective.find_by(patient_id: patient.id) == nil && History.find_by(patient_id: patient.id) == nil && Comment.find_by(patient_id: patient.id) == nil
          session["patient_id"] = patient.id
          redirect "/patients/#{patient.id}/new" 
        elsif patient.authenticate(params["password"])
          session["patient_id"] = patient.id
          redirect "/patients/#{patient.id}/info"
        else
          flash[:error] = "Sorry, the password that you entered does not match our records."
          redirect '/login'
        end
      end

      get '/login' do

        erb :'/patients/login'
      end

      get '/logout' do
        session.delete("patient_id")

        redirect '/login'
      end

      post '/logout' do
        session.delete("patient_id")
        
        redirect '/login'
      end
end
