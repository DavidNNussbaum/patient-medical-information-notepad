class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :identifier
      t.text :note
      t.text :items_to_discuss
      t.text :questions
      t.references :patient
    end
  end
end
