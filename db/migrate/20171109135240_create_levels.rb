class CreateLevels < ActiveRecord::Migration[5.1]
  def change
    create_table :levels do |t|
      t.string :nombre
      t.integer :puntos

      t.timestamps
    end
  end
end
