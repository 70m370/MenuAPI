class Menu < ApplicationRecord
  has_many :menu_items
  has_one :restaurant
  
  belongs_to :restaurant

  validates :name, presence: true
  validates :restaurant, presence: true
end
