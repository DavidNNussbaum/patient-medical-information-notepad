Create subfolders in views: 1)patients (contains signup.erb, info.erb - change erb name on route) 
2)sessions (contains login erb - change erb name on route.).

DOES /logout OR /signup OR /login HAVE patient_id?

FROM patient_controller.rb - BUT HOW AVOID UPDATE RE:patient_id? - ONLY WANT TO UPDATE ONCE:
post '/info' do
    @patient = Patient.find(session["patient_id"]
    history = History.new(:diagnoses => params[:histories][:diagnoses]
    history.medications = params[:histories][:medications]
    history.allergies = params[:histories][:allergies]
    history.current_treatments = params[:histories][:current_treatments]
    history.surgeries = params[:histories][:surgeries]
    history.immunizations_with_dates = params[:histories][:immunizations_with_dates]
    history.update(:patient_id => @patient.id)
    histories.save
    subjective = Subjective.create(:location => params[:subjectives][:location]
    subjective.observed_changes = params[:subjectives][:observed_changes]
    subjectives.sensation_changes = params[:subjectives][:sensation_changes]
    subjectives.scale_1_to_10 = params[:subjectives][:scale_1_to_10]
    subjectives.length_of_time = params[:subjectives][:length_of_time]
    subjectives.update(:patient_id => @patient.id)
    subjectives.save
    
    redirect '/info'
end
OR:

@patient.history.build(attr_1:value, attr_2: value)
@patient.history.save

