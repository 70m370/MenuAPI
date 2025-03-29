class Restaurant < ApplicationRecord
  has_many :menus

  validates :name, presence: true
  #validates :menus, presence: true
end
