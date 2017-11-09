class User < ApplicationRecord
  belongs_to :level
  belongs_to :faculties
  has_many :questions
  has_many :answer
  has_many :question_comments
  has_many :answer_comments
  has_many :question_votes
  has_many :answer_votes
  has_many :question_comment_votes
  has_many :answer_comment_votes
end
