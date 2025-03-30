class MenuItem < ApplicationRecord
  belongs_to :menu

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :menu, presence: true
end
