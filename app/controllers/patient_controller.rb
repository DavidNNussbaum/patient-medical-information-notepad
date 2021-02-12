class PatientController < ApplicationController

    post '/signup' do
        patient = Patient.new(username: params["username"], password: params["password"])
            if patient.save
                session["patient_id"] = patient.id
                redirect '/new'
            else
              redirect '/show'
        end
      end
    
    
    post 'patients/:id/info' do
        @patient = Patient.find(session["patient_id"])
        histories = History.new(:diagnoses => params[:histories][:diagnoses])
        histories.update(:medications => params[:histories][:medications])
        histories.update(:allergies => params[:histories][:allergies])
        histories.update(:current_treatments => params[:histories][:current_treatments])
        histories.update(:surgeries => params[:histories][:surgeries])
        histories.update(:surgeries => params[:histories][:surgeries])
        histories.update(:immunizations_with_dates => params[:histories][:immunizations_with_dates])
        histories.update(:patient_id => @patient.id)
        histories.save
        subjectives = Subjective.create(:location => params[:subjectives][:location])
        subjectives.update(:observed_changes => params[:subjectives][:observed_changes])
        subjectives.update(:sensation_changes => params[:subjectives][:sensation_changes])
        subjectives.update(:scale_1_to_10 => params[:subjectives][:scale_1_to_10])
        subjectives.update(:length_of_time => params[:subjectives][:length_of_time])
        subjectives.update(:patient_id => @patient.id)
        subjectives.save
        
        redirect 'patients/:id/info'
    end

    get 'patients/:id/info' do
        redirect_if_not_logged_in
        @patient = Patient.find(session["patient_id"])
        redirect "/patients/#{current_user.id}" if current_use != @patient
        @patient.history = History.where(patient_id: @patient.id)
        @patient.subjective = Subjective.where(patient_id: @patient.id)
         
        erb :patients/info
    end

    get 'patients/:id/edit' do
        @patient = Patient.find(session["patient_id"])
        @histories = History.where(patient_id: @patient.id)
        @subjectives = Subjective.where(patient_id: @patient.id)
        @comments = Comment.where(patient_id: @patient.id)
         
        erb :edit
    end

     patch 'patients/:id/info' do
        @patient = Patient.find(session["patient_id"])
        histories = History.where(patient_id: @patient.id)
        if params[:histories]
        histories.update_all(:diagnoses => params[:histories]&.fetch(:diagnoses))
        histories.update_all(:medications => params[:histories]&.fetch(:medications))
        histories.update_all(:allergies => params[:histories]&.fetch(:allergies))
        histories.update_all(:current_treatments => params[:histories]&.fetch(:current_treatments))
        histories.update_all(:surgeries => params[:histories]&.fetch(:surgeries))
        histories.update_all(:immunizations_with_dates => params[:histories]&.fetch(:immunizations_with_dates))
        end
        if params[:subjectives]
        subjectives = Subjective.where(patient_id: @patient.id)
        subjectives.update_all(:location => params[:subjectives]&.fetch(:location))
        subjectives.update_all(:observed_changes => params[:subjectives]&.fetch(:observed_changes))
        subjectives.update_all(:sensation_changes => params[:subjectives]&.fetch(:sensation_changes))
        subjectives.update_all(:scale_1_to_10 => params[:subjectives]&.fetch(:scale_1_to_10))
        subjectives.update_all(:length_of_time => params[:subjectives]&.fetch(:length_of_time))
        end
        if params[:comments]
        comments = Comment.where(patient_id: @patient.id)
        comments.update_all(:note => params[:comments]&.fetch(:note))
        comments.update_all(:items_to_discuss => params[:comments]&.fetch(:items_to_discuss))
        comments.update_all(:questions => params[:comments]&.fetch(:questions))
        end
        @histories = History.where(patient_id: @patient.id)
        @subjectives = Subjective.where(patient_id: @patient.id)
        @comments = Comment.where(patient_id: @patient.id)

        erb :patients/info
     end

    post 'patients/:id/delete' do
        @patient = Patient.find(session["patient_id"])
        @pull_his = History.where(patient_id: @patient.id).destroy_all
        @pull_sub = Subjective.where(patient_id: @patient.id).destroy_all
        @pull_com = Comment.where(patient_id: @patient.id).destroy_all
         
        redirect '/new'
    end
end



  

 