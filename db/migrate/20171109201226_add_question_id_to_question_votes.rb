class AddQuestionIdToQuestionVotes < ActiveRecord::Migration[5.1]
  def change
    add_column :question_votes, :question_id, :integer
  end
end
