class AddCommentIdToQuestionCommentVotes < ActiveRecord::Migration[5.1]
  def change
    add_column :question_comment_votes, :question_id, :integer
  end
end
