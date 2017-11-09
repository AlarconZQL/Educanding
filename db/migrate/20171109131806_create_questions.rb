class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :contenido
      t.integer :num_visitas
      t.integer :mejor_respuesta

      t.timestamps
    end
  end
end
