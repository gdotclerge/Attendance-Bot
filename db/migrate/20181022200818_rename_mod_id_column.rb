class RenameModIdColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :mod_id, :cohort_id
  end
end
