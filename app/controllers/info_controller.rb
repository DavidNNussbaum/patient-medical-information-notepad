class InfoController < ApplicationController

    get '/info' do
        erb :blank
    end

    post '/info' do
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
        comments = Comment.create(:note => params[:comments][:note])
        comments.update(:items_to_discuss => params[:comments][:items_to_discuss])
        comments.update(:questions => params[:comments][:questions])
        comments.update(:patient_id => @patient.id)
        comments.save
        redirect '/show'
    end

    get '/show' do
        @patient = Patient.find(session["patient_id"])
        @pull_his = History.where(patient_id: @patient.id)
        @pull_sub = Subjective.where(patient_id: @patient.id)
        @pull_com = Comment.where(patient_id: @patient.id)
        erb :show
    end

    get '/edit' do
        erb :edit
    end

    post '/edit_go' do
        erb :edit
    end

    post '/edit' do
        @patient = Patient.find(session["patient_id"])
        histories = History.where(patient_id: @patient.id)
        histories.update(:diagnoses => params[:histories][:diagnoses])
        histories.update(:medications => params[:histories][:medications])
        histories.update(:allergies => params[:histories][:allergies])
        histories.update(:current_treatments => params[:histories][:current_treatments])
        histories.update(:surgeries => params[:histories][:surgeries])
        histories.update(:surgeries => params[:histories][:surgeries])
        histories.update(:immunizations_with_dates => params[:histories][:immunizations_with_dates])
        histories.save
        subjectives = Subjective.where(patient_id: @patient.id)
        subjectives.update(:location => params[:subjectives][:location])
        subjectives.update(:observed_changes => params[:subjectives][:observed_changes])
        subjectives.update(:sensation_changes => params[:subjectives][:sensation_changes])
        subjectives.update(:scale_1_to_10 => params[:subjectives][:scale_1_to_10])
        subjectives.update(:length_of_time => params[:subjectives][:length_of_time])
        subjectives.save
        comments = Comment.where(patient_id: @patient.id)
        comments.update(:note => params[:comments][:note])
        comments.update(:items_to_discuss => params[:comments][:items_to_discuss])
        comments.update(:questions => params[:comments][:questions])
        comments.save
        redirect '/show'
    end

    post '/delete' do
        @patient = Patient.find(session["patient_id"])
        @pull_his = History.where(patient_id: @patient.id}
             @pull_his.each do |his|  
              his.diagnoses.delete  
              his.medications.delete
              his.allergies.delete  
              his.current_treatments.delete 
              his.surgeries.delete  
              his.immunizations_with_dates.delete
              end
        @pull_sub = Subjective.where(patient_id: @patient.id)
        @pull_sub.each do |sub| 
             sub.location.delete
             sub.observed_changes.delete
             sub.sensation_changes.delete
             sub.scale_1_to_10.delete
             sub.length_of_time.delete
             end 
        @pull_com = Comment.where(patient_id: @patient.id)
        @pull_com.each do |com| 
             com.note.delete
             com.items_to_discuss.delete
             com.questions.delete
             end 

        erb :blank
    end
end



 # @patient = Patient.find(session["patient_id"])
        # histories = History.create(params)
        # histories = histories.patient_id == @patient.id
        # subjectives = Subjective.create(params)
        # subjectives = subjectives.patient_id == @patient.id
        # comments = Comment.create(params)
        # comments = comments.patient_id == @patient.id
        # erb :show

        # @patient = Patient.find(session["patient_id"])
        # histories = History.create(params[:diagnoses])
        # histories.update(params[:medications])
        # histories.update(params[:allergies])
        # histories.update(params[:current_treatments])
        # histories.update(params[:surgeries])
        # histories.update(params[:surgeries])
        # histories.update(params[:immunizations_with_dates])
        # histories.update(patient_id: @patient.id)
        # subjectives = Subjective.create(params[:location])
        # subjectives.update(params[:observed_changes])
        # subjectives.update(params[:sensation_changes])
        # subjectives.update(params[:scale_1_to_10])
        # subjectives.update(params[:length_of_time])
        # subjectives.update(patient_id: @patient.id)
        # comments = Comment.create(params[:note])
        # comments.update(params[:items_to_discuss])
        # comments.update(params[:questions])
        # comments.update(patient_id: @patient.id)
    
#     get '/info' do
#         redirect_if_not_logged_in
#         @patient = Patient.find(session["user_id"])
#         @info = @patient.info
#         erb :show
#     end

#     get '/info/new' do
#         @patient = Patient.find(session["user_id"])
#         redirect_if_not_logged_in
#         erb :notes/new
#     end

#     get '/info/:id' do
#         @patient = Patient.find(session["user_id"])
#         redirect_if_not_logged_in
#         @info = Info.find_by(id: params[:id])
#         erb :show
#     end

  
#     post '/info' do
#         redirect_if_not_logged_in
#         redirect_error_if_not_authorized
#         # patient = Patient.username(params["username"])
#         @patient = Patient.find(session["user_id"])
#         info = Info.create(params["info"])
#         redirect '/show/#{patient}'
#     end

  
#     get '/info/:id/edit' do
#         @patient = Patient.find(session["user_id"])
#         redirect_if_not_logged_in
#         redirect_error_if_not_authorized
#         @info = Info.find_by(id: params[:id])
#         erb :info/edit
#     end

#     patch '/info/:id' do
#         @patient = Patient.find(session["user_id"])
#         redirect_if_not_logged_in
#         redirect_error_if_not_authorized
#         info = Info.find_by(id: params[:id])
#         info.update(params["info"])
#         redirect "/info/#{info.id}"
#     end

#     delete '/info/:id' do
#         @patient = Patient.find(session["user_id"])
#         redirect_if_not_logged_in
#         redirect_error_if_not_authorized
#         info = Info.find_by(id: params[:id])
#         info.delete
#         redirect "/info"
#     end

#     private

#     def redirect_error_if_not_authorized
#         redirect "/error"
#     end
# end

 