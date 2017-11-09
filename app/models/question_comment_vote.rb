class QuestionCommentVote < ApplicationRecord
  belongs_to :question_comment
  belongs_to :user
end
