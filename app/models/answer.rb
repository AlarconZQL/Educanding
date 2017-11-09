class Answer < ApplicationRecord
  has_many :comments
  belongs_to :question
  has_many :answer_votes
  belongs_to :user
end
