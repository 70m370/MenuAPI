class Item < ApplicationRecord
  has_many :menu_items

  # unique item
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
