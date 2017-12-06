class RemoveActivoFromLevels < ActiveRecord::Migration[5.1]
  def change
    remove_column :levels, :activo, :boolean
  end
end
