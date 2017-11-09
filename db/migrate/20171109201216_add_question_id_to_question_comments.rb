class AddQuestionIdToQuestionComments < ActiveRecord::Migration[5.1]
  def change
    add_column :question_comments, :question_id, :integer
  end
end
