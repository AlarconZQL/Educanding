class QuestionComment < ApplicationRecord
  has_many :question_comment_votes, dependent: :destroy
  belongs_to :question
  belongs_to :user
  validates :contenido, presence: true
end
