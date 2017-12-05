class Functionality < ApplicationRecord

  has_many :level_functionalities, dependent: :destroy

end
