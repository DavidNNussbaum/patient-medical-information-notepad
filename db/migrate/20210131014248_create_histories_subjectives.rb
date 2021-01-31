class CreateHistoriesSubjectives < ActiveRecord::Migration
  def change
    create_table :histories_subjectives do |t|
      t.string :histories_id
      t.string :sbjectives_id
      t.string :patient_id
    end
  end
end
