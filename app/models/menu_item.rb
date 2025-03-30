class MenuItem < ApplicationRecord
  has_many :menu
  belongs_to :menu

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :menu, presence: true
end
