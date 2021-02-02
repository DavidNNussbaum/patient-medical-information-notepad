class InfoController < ApplicationController

    get '/info' do
        erb :blank
    end

    post '/info' do
        @patient = Patient.find(session["patient_id"])
        histories = History.new(:diagnoses => params[:diagnoses])
        histories.update(:medications => params[:medications])
        histories.update(:allergies => params[:allergies])
        histories.update(:current_treatments => params[:current_treatments])
        histories.update(:surgeries => params[:surgeries])
        histories.update(:surgeries => params[:surgeries])
        histories.update(:immunizations_with_dates => params[:immunizations_with_dates])
        histories.update(:patient_id => @patient.id)
        histories.save
        subjectives = Subjective.create(:location => params[:location])
        subjectives.update(:observed_changes => params[:observed_changes])
        subjectives.update(:sensation_changes => params[:sensation_changes])
        subjectives.update(:scale_1_to_10 => params[:scale_1_to_10])
        subjectives.update(:length_of_time => params[:length_of_time])
        subjectives.update(:patient_id => @patient.id)
        subjectives.save
        comments = Comment.create(:note => params[:note])
        comments.update(:items_to_discuss => params[:items_to_discuss])
        comments.update(:questions => params[:questions])
        comments.update(:patient_id => @patient.id)
        comments.save
        redirect '/show'
    end

    get '/show' do
        @patient = Patient.find(session["patient_id"])
        # cor_his = History.find_by(username: @patient)
        pull_his = History.all.find_by(patient_id: @patient.id)
        pull_his.each do |his|
            puts his
        end
        @patient = Patient.find(session["patient_id"])
        # cor_sub = Subjective.find_by(username: @patient)
        pull_sub = Subjective.find_by(patient_id: @patient.id)
        pull_sub.each do |sub|
            puts sub
        end
        @patient = Patient.find(session["patient_id"])
        # cor_com = Comment.find_by(username: @patient)
        pull_com = Comment.all.find_by(patient_id: @patient.id)
        pull_com.each do |com|
            puts com 
        erb :show
      end
    end

    get '/edit' do
        erb :edit
    end

    post '/edit' do
        @patient = Patient.find(session["patient_id"])
        histories = History.find_by(:patient_id => @patient.id)
        histories.update(:diagnoses => params[:diagnoses])
        histories.update(:medications => params[:medications])
        histories.update(:allergies => params[:allergies])
        histories.update(:current_treatments => params[:current_treatments])
        histories.update(:surgeries => params[:surgeries])
        histories.update(:surgeries => params[:surgeries])
        histories.update(:immunizations_with_dates => params[:immunizations_with_dates])
        histories.save
        subjectives = Subjective.find_by(:patient_id => @patient.id)
        subjectives.update(:location => params[:location])
        subjectives.update(:observed_changes => params[:observed_changes])
        subjectives.update(:sensation_changes => params[:sensation_changes])
        subjectives.update(:scale_1_to_10 => params[:scale_1_to_10])
        subjectives.update(:length_of_time => params[:length_of_time])
        subjectives.save
        comments = Comment.find_by(:patient_id => @patient.id)
        comments.update(:note => params[:note])
        comments.update(:items_to_discuss => params[:items_to_discuss])
        comments.update(:questions => params[:questions])
        comments.save
        redirect '/show'
    end

    post '/delete' do
        History.current_user.delete
        Subjective.current_user.delete
        Comment.current_user.delete
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

 