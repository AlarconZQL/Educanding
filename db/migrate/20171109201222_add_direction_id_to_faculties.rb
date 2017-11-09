class AddDirectionIdToFaculties < ActiveRecord::Migration[5.1]
  def change
    add_column :faculties, :direction_id, :integer
  end
end
