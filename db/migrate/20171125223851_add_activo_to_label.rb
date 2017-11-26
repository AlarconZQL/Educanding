class AddActivoToLabel < ActiveRecord::Migration[5.1]
  def change
    add_column :labels, :activo, :boolean
  end
end
