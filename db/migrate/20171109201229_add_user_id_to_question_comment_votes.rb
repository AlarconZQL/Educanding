class AddUserIdToQuestionCommentVotes < ActiveRecord::Migration[5.1]
  def change
    add_column :question_comment_votes, :user_id, :integer
  end
end
