class DropHistoriesSubjectives < ActiveRecord::Migration
  def change
    drop_table :histories_subjectives
  end
end
