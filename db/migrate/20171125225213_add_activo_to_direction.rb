class AddActivoToDirection < ActiveRecord::Migration[5.1]
  def change
    add_column :directions, :activo, :boolean
  end
end
