class Answer < ApplicationRecord
  has_many :answer_comments
  has_many :answer_votes
  belongs_to :question
  belongs_to :user
end
