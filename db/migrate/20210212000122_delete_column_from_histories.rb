class DeleteColumnFromHistories < ActiveRecord::Migration
  def change
    remove_column :histories, :subjective_id, :integer
  end
end
