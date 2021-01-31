class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :username
      t.string :password_digest
    end
  end
end
