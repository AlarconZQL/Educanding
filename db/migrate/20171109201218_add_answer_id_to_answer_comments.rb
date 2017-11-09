class AddAnswerIdToAnswerComments < ActiveRecord::Migration[5.1]
  def change
    add_column :answer_comments, :answer_id, :integer
  end
end
