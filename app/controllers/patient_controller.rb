class PatientController < ApplicationController

    get '/patients/:id/sessions' do
        erb :'/sessions/index'
    end

    get "/patients/:id/new" do
        @patient = Patient.find(session["patient_id"])
        erb :new
end
    
    post '/signup' do
        patient = Patient.new(username: params["username"], password: params["password"])
        if patient.save
            session["patient_id"] = patient.id
            redirect '/new'
        else
            redirect "/patients/:id/new" 
            
        end
    end
    
    
    post '/patients/:id/info' do
        redirect_if_not_logged_in
        patient = Patient.find(session["patient_id"])
        history = History.new(:diagnoses => params[:histories][:diagnoses])
        history.allergies = params[:histories][:allergies]
        history.current_treatments = params[:histories][:current_treatments]
        history.surgeries = params[:histories][:surgeries]
        history.immunizations_with_dates = params[:histories][:immunizations_with_dates]
        history.patient_id = @patient.id
        history.save
        subjective = Subjective.create(:location => params[:subjectives][:location])
        subjective.observed_changes = params[:subjectives][:observed_changes]
        subjective.sensation_changes = params[:subjectives][:sensation_changes]
        subjective.scale_1_to_10 = params[:subjectives][:scale_1_to_10]
        subjective.length_of_time = params[:subjectives][:length_of_time]
        subjective.patient_id = @patient.id
        subjective.save
   
        redirect 'patients/:id/info'
    end

    get '/patients/:id/info' do
        redirect_if_not_logged_in
        @patient = Patient.find(session["patient_id"])
        if Subjective.find_by(patient_id: @patient.id) == nil && History.find_by(patient_id: @patient.id) == nil && Comment.find_by(patient_id: @patient.id) == nil
            redirect "/patients/#{current_user.id}/new" 
        elsif current_user != @patient
            redirect "/patients/#{current_user.id}"
        end
        @history = History.find_by(patient_id: @patient.id)
        @subjective = Subjective.find_by(patient_id: @patient.id)
         
        erb :'/patients/info'
    end

    get '/patients/:id/edit' do
        redirect_if_not_logged_in
        @patient = Patient.find(session["patient_id"])
        @histories = History.where(patient_id: @patient.id)
        @subjectives = Subjective.where(patient_id: @patient.id)
        @comments = Comment.where(patient_id: @patient.id)
         
        erb :edit
    end

     patch '/patients/:id/info' do
        redirect_if_not_logged_in
        patient = Patient.find(session["patient_id"])
        histories = History.where(patient_id: patient.id)
        if params[:histories]
            histories.update_all(:diagnoses => params[:histories]&.fetch(:diagnoses))
            histories.update_all(:medications => params[:histories]&.fetch(:medications))
            histories.update_all(:allergies => params[:histories]&.fetch(:allergies))
            histories.update_all(:current_treatments => params[:histories]&.fetch(:current_treatments))
            histories.update_all(:surgeries => params[:histories]&.fetch(:surgeries))
            histories.update_all(:immunizations_with_dates => params[:histories]&.fetch(:immunizations_with_dates))
        end
        if params[:subjectives]
            subjectives = Subjective.where(patient_id: patient.id)
            subjectives.update_all(:location => params[:subjectives]&.fetch(:location))
            subjectives.update_all(:observed_changes => params[:subjectives]&.fetch(:observed_changes))
            subjectives.update_all(:sensation_changes => params[:subjectives]&.fetch(:sensation_changes))
            subjectives.update_all(:scale_1_to_10 => params[:subjectives]&.fetch(:scale_1_to_10))
            subjectives.update_all(:length_of_time => params[:subjectives]&.fetch(:length_of_time))
        end
        if params[:comments]
            comments = Comment.where(patient_id: patient.id)
            comments.update_all(:note => params[:comments]&.fetch(:note))
            comments.update_all(:items_to_discuss => params[:comments]&.fetch(:items_to_discuss))
            comments.update_all(:questions => params[:comments]&.fetch(:questions))
        end
        @histories = History.where(patient_id: patient.id)
        @subjectives = Subjective.where(patient_id: patient.id)
        @comments = Comment.where(patient_id: patient.id)

        redirect "patients/#{patient.id}/info"
     end

    delete '/patients/:id/info' do
        redirect_if_not_logged_in
        @patient = Patient.find(session["patient_id"])
        @pull_his = History.where(patient_id: @patient.id).destroy_all
        @pull_sub = Subjective.where(patient_id: @patient.id).destroy_all
        @pull_com = Comment.where(patient_id: @patient.id).destroy_all
         
        redirect "/patients/#{@patient.id}/new"
    end
end



  

 