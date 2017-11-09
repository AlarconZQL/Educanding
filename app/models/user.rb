class User < ApplicationRecord
  belongs_to :level
  belongs_to :faculty
  belongs_to :question_vote
  belongs_to :answer_vote
  belongs_to :comment_vote
  has_many :questions
  has_many :answers
  has_many :comments
end
