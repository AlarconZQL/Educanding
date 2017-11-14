class Faculty < ApplicationRecord
  belongs_to :direction
  has_many :question
  has_many :users
  validates :nombre, presence: true, uniqueness: true
end
