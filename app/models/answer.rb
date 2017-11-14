class Answer < ApplicationRecord
  has_many :answer_comments, dependent: :destroy
  has_many :answer_votes, dependent: :destroy
  belongs_to :question
  belongs_to :user
  validates :contenido, presence: true
end
