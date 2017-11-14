class User < ApplicationRecord
  belongs_to :level
  belongs_to :faculty, optional:true
  has_many :questions
  has_many :answer
  has_many :question_comments
  has_many :answer_comments
  has_many :question_votes
  has_many :answer_votes
  has_many :question_comment_votes
  has_many :answer_comment_votes
  validates :nombre, presence: true
  validates :apellido, presence: true
  validates :mail, presence: true
  validates :pass, presence: true
end
