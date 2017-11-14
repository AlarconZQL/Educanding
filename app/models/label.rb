class Label < ApplicationRecord
  has_many :question_labels
  validates :nombre, presence: true
end
