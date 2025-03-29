class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :menus
end
