class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :question_comments, dependent: :destroy
  has_many :question_votes, dependent: :destroy
  belongs_to :user
  belongs_to :faculty
  has_many :question_labels, dependent: :destroy
  validates :contenido, presence: true
end
