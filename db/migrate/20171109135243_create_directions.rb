class CreateDirections < ActiveRecord::Migration[5.1]
  def change
    create_table :directions do |t|
      t.string :ciudad
      t.string :calle

      t.timestamps
    end
  end
end
