class CreateQuestionLabels < ActiveRecord::Migration[5.1]
  def change
    create_table :question_labels do |t|
      t.integer :pregunta_id
      t.integer :etiqueta_id

      t.timestamps
    end
  end
end
