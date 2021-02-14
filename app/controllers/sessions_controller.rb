class SessionsController < ApplicationController

    post '/login' do
        patient = Patient.find_by_username(params["username"])
         if patient.authenticate(params["password"])
            session["patient_id"] = patient.id
            redirect "patients/#{patient.id}/info"
            else
                redirect '/login'
            end
      end

      get '/login' do

        erb :'/patients/login'
      end

      post '/logout' do
        session.delete("patient_id")
        
        redirect '/login'
      end
end