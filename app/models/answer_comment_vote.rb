class AnswerCommentVote < ApplicationRecord
  belongs_to :answer_comment
  belongs_to :user
end
