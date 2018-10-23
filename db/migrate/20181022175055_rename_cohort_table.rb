class RenameCohortTable < ActiveRecord::Migration[5.2]
  def change
    add_column :mods, :name, :string
    rename_column :mods, :number, :mod
    rename_table :mods, :cohorts
  end
end
