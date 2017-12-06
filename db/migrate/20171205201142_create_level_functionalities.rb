class CreateLevelFunctionalities < ActiveRecord::Migration[5.1]
  def change
    create_table :level_functionalities do |t|
      t.integer :level_id
      t.integer :functionality_id

      t.timestamps
    end
  end
end
