class Level < ApplicationRecord
  has_many :users
  validates :nombre, presence: true
  validates :puntos, presence: true

end
