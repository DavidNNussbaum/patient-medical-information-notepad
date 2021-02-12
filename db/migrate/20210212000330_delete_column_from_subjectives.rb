class DeleteColumnFromSubjectives < ActiveRecord::Migration
  def change
    remove_column :subjectives, :history_id, :integer
  end
end
