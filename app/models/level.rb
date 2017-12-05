class Level < ApplicationRecord
  has_many :users
  validates :nombre, presence: true
  validates :puntos, presence: true

  has_many :level_functionalities, dependent: :destroy



end
