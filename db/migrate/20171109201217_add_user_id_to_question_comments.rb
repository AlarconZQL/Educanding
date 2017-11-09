class AddUserIdToQuestionComments < ActiveRecord::Migration[5.1]
  def change
    add_column :question_comments, :user_id, :integer
  end
end
