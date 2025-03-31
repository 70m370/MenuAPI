class Menu < ApplicationRecord
  has_many :menu_items
  belongs_to :restaurant

  validates :name, presence: true
  validates :restaurant, presence: true
end
