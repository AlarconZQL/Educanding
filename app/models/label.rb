class Label < ApplicationRecord
  has_many :question_labels, dependent: :destroy
  validates :nombre, presence: true, uniqueness: true
end
