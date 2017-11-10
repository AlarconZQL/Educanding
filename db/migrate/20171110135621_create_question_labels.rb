class CreateQuestionLabels < ActiveRecord::Migration[5.1]
  def change
    create_table :question_labels do |t|
      t.integer :question_id
      t.integer :label_id

      t.timestamps
    end
  end
end
