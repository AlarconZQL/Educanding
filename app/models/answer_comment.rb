class AnswerComment < ApplicationRecord
  has_many :answer_comment_votes, dependent: :destroy
  belongs_to :answer
  belongs_to :user
  validates :contenido, presence: true
end
