class Comment < ApplicationRecord
  belongs_to :question
  belongs_to :answer
  has_many :comment_votes
  belongs_to :user
end
