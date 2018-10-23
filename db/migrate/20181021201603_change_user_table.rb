class ChangeUserTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :sheet_key, :sheet_id
    rename_column :users, :mod, :mod_id
  end
end
