class Direction < ApplicationRecord
  has_many :faculties
  validates :ciudad, presence: true
  validates :calle, presence: true
end
