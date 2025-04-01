class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name
  # leave id for now
  has_many :menus
end
