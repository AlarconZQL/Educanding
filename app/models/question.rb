class Question < ApplicationRecord
  has_many :comments
  has_many :answers
  has_many :question_votes
  has_many :labels
  belongs_to :faculty
  belongs_to :user
end
