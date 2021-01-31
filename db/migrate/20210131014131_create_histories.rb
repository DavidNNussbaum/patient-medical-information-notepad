class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.text :diagnoses
      t.text :medications
      t.text :allergies
      t.text :current_treatments
      t.text :surgeries
      t.text :immunizations_with_dates
      t.string :patient_id
      t.string :subjective_id
    end
  end
end
