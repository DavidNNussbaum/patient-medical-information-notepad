class SessionsController < ApplicationController

    post '/login' do
        patient = Patient.find_by_username(params["username"])
         if patient.authenticate(params["password"])
             session["patient_id"] = patient.id
            redirect '/show'
            else
                redirect '/login'
            end
      end

      get '/logout' do
        session.delete("patient_id")
        erb :login
      end
end