class CreateTableSheet < ActiveRecord::Migration[5.2]
  def change
    create_table :sheets do |t|
      t.string :sheet_key
      t.string :url
    end
  end
end
