class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.text   :diagnoses
      t.text   :medications
      t.text   :allergies
      t.text   :current_treatments
      t.text   :surgeries
      t.text   :immunizations_with_dates
      t.references :patient
      t.references :subjective
    end
  end
end
