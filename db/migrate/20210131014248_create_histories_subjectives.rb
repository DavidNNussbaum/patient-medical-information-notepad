class CreateHistoriesSubjectives < ActiveRecord::Migration
  def change
    create_table :histories_subjectives do |t|
      t.references :history
      t.references :subjective
      t.references :patient
    end
  end
end
