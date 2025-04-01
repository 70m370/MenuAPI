class Restaurant < ApplicationRecord
  has_many :menus
  has_many :items

  validates :name, presence: true
  # validates :menus, presence: true
end
