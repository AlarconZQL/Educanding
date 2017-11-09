class AddUserIdToAnswerCommentVotes < ActiveRecord::Migration[5.1]
  def change
    add_column :answer_comment_votes, :user_id, :integer
  end
end
