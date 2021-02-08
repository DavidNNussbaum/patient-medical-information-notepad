class CreateSubjectives < ActiveRecord::Migration
  def change
    create_table :subjectives do |t|
      t.text   :location
      t.text   :observed_changes
      t.text   :sensation_changes
      t.string :scale_1_to_10
      t.text   :length_of_time
      t.references :history
      t.references :patient
    end
  end
end
