class AddCommentIdToAnswerCommentVotes < ActiveRecord::Migration[5.1]
  def change
    add_column :answer_comment_votes, :answer_comment_id, :integer
  end
end
