class CommentsController < ApplicationController
     

    get '/patients/:patient_id/comments/new' do
        redirect_if_not_logged_in
        @patient = Patient.find(params[:patient_id])
        erb :'/comments/new'
    end

    
    get '/patients/:patient_id/comment/:id/edit' do
        redirect_if_not_logged_in
        @comment = Comment.find(params[:id])
        erb :'/comments/edit'
    end

    get '/patients/:patient_id/comment/:id' do
        redirect_if_not_logged_in
        @patient = Patient.find(params[:patient_id])
        @comment = Comment.find(params[:id])
        erb :'/comments/show'
    end

    get '/patients/:patient_id/comments' do
        redirect_if_not_logged_in
        @patient = Patient.find(params[:patient_id])
        @comments = Comment.where(patient_id: @patient.id)
        erb :'/comments/index'
    end

    post '/patients/:patient_id/comments' do
        redirect_if_not_logged_in
        comment = Comment.create(identifier: params[:comments][:identifier], note: params[:comments][:identifier], items_to_discuss: params[:comments][:items_to_discuss], questions: params[:comments][:questions], patient_id: params[:patient_id])

        redirect "/patients/#{comment.patient_id}/comment/#{comment.id}"
    end

     patch '/patients/:patient_id/comment/:id' do
        redirect_if_not_logged_in
        comment = Comment.find(params[:id])
        comment.update(identifier: params[:comments][:identifier], note: params[:comments][:note], items_to_discuss: params[:comments][:items_to_discuss], questions: params[:comments][:questions])
        redirect "/patients/#{comment.patient_id}/comment/#{comment.id}"
     end

    
    delete '/patients/:patient_id/comment/:id' do
        redirect_if_not_logged_in
        patient = Patient.find(params[:patient_id])
        comment = Comment.find_by(id: params[:id])
        comment.delete
        redirect "/patients/#{patient.id}/comments"
    end
end