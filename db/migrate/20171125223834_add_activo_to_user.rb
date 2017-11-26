class AddActivoToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :activo, :boolean
  end
end
