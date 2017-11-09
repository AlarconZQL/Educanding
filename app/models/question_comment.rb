class QuestionComment < ApplicationRecord
  has_many :question_comment_votes
  belongs_to :question
  belongs_to :user
end
