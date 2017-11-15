class RemoveQuestionIdFromQuestionCommentVotes < ActiveRecord::Migration[5.1]
  def change
    remove_column :question_comment_votes, :question_id, :integer
  end
end
