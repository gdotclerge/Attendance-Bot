class ChangeSheetIdType < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :sheet_id, 'integer USING CAST(sheet_id AS integer)'
  end
end
