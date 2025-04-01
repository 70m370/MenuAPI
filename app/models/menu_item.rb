class MenuItem < ApplicationRecord
  belongs_to :item
  belongs_to :menu

  validates :price, presence: true
  validates :item, presence: true
  validates :item_id, uniqueness: { scope: :menu_id, message: "Item Already Exist inside this menu" }
end
