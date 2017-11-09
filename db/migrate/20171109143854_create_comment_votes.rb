class CreateCommentVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :comment_votes do |t|
      t.boolean :tipo

      t.timestamps
    end
  end
end
