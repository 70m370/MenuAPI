class MenuItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :price
  # dont forget to take id's out at the end
  def name
    object.item.name
  end
end
