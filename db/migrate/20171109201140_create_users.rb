class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :nombre
      t.string :apellido
      t.string :mail
      t.integer :puntos
      t.string :pass

      t.timestamps
    end
  end
end
