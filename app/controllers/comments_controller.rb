class CommentsController < ApplicationController
     

    get '/patient/:patient_id/comments/new' do
        @patient = Patient.find(params[:patient_id])
        erb :'/comments/new'
    end

    
    get '/patient/:patient_id/comment/:id/edit' do
        @comment = Comment.find(params[:id])
        erb :'/comments/edit'
    end

    get '/patient/:patient_id/comment/:id' do
        @patient = Patient.find(params[:patient_id])
        @comment = Comment.find(params[:id])
        erb :'/comments/show'
    end

    get '/patient/:patient_id/comments' do
        @patient = Patient.find(params[:patient_id])
        @comments = Comment.where(patient_id: @patient.id)
        erb :'/comments/index'
    end

    post '/patient/:patient_id/comments' do
        comment = Comment.create(identifier: params[:comments][:identifier], note: params[:comments][:identifier], items_to_discuss: params[:comments][:items_to_discuss], questions: params[:comments][:questions], patient_id: params[:patient_id])

        redirect "/patient/#{comment.patient_id}/comment/#{comment.id}"
    end

     patch '/patient/:patient_id/comment/:id' do
        comment = Comment.find(params[:id])
        comment.update(identifier: params[:comments][:identifier], note: params[:comments][:identifier], items_to_discuss: params[:comments][:items_to_discuss], questions: params[:comments][:questions])
        redirect "/patient/#{comment.patient_id}/comment/#{comment.id}"
     end

    
    delete '/patient/:patient_id/comment/:id' do
        patient = Patient.find(params[:patient_id])
        comment = Comment.find_by(id: params[:id])
        comment.delete
        redirect "/patient/#{patient.id}/comments"
    end
end