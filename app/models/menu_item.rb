class MenuItem < ApplicationRecord
  belongs_to :menu

  validates :menu, presence: true
end
