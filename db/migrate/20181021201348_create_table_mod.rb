class CreateTableMod < ActiveRecord::Migration[5.2]
  def change
    create_table :mods do |t|
      t.integer :number
    end
  end
end
