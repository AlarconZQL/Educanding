class Question < ApplicationRecord
  has_many :answers
  has_many :question_comments
  has_many :question_votes
  belongs_to :user
  belongs_to :faculty
  has_many :question_labels
end
