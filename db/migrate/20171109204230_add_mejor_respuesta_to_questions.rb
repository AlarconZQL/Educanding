class AddMejorRespuestaToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :mejor_respuesta, :integer
  end
end
