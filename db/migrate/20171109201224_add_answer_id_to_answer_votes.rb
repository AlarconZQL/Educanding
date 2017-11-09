class AddAnswerIdToAnswerVotes < ActiveRecord::Migration[5.1]
  def change
    add_column :answer_votes, :answer_id, :integer
  end
end
