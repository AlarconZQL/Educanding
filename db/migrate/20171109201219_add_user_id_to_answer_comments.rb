class AddUserIdToAnswerComments < ActiveRecord::Migration[5.1]
  def change
    add_column :answer_comments, :user_id, :integer
  end
end
