class AddActivoToFaculty < ActiveRecord::Migration[5.1]
  def change
    add_column :faculties, :activo, :boolean
  end
end
