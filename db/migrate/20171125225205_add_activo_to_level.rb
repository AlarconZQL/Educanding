class AddActivoToLevel < ActiveRecord::Migration[5.1]
  def change
    add_column :levels, :activo, :boolean
  end
end
