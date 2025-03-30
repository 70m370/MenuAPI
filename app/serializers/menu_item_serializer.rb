class MenuItemSerializer < ActiveModel::Serializer
  attributes :id, :name
  #dont forget to take id's out at the end
end
