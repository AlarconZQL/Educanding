class AnswerComment < ApplicationRecord
  has_many :answer_comment_votes
  belongs_to :answer
  belongs_to :user  
end
