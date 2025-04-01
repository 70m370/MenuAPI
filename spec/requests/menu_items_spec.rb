require 'rails_helper'

RSpec.describe "/menus_items/ endpoint", type: :request do
  describe "GET /menus" do
    # show
    it "show all menu items" do
      get api_v1_menu_items_path
      expect(response).to have_http_status(:ok) # 200
    end
  end

  # index
  describe "GET /menu_items/:id" do
    it "get menu item by id" do
      restaurant = Restaurant.create(name: "Los Pollos Hermanos")
      menu = Menu.create(name: "test menu", restaurant_id: restaurant.id)
      item = Item.create(name: "test-item")
      menu_item = MenuItem.create!(price: 10, menu_id: menu.id, item_id: item.id)

      get api_v1_menu_item_path(menu_item.id)

      expect(response).to have_http_status(:ok) # 200
      json_response = JSON.parse(response.body)
      # puts "#{json_response} GET /menu_items/:id "
      expect(json_response["name"]).to eq(item.name)
    end

    it "Return menu item not found" do
      get api_v1_menu_item_path(99)
      expect(response).to have_http_status(:not_found) # 404
    end
  end

  # post
  describe "POST /menu_items/" do
    # create

    it "create a menu item" do
      restaurant = Restaurant.create(name: "Los Pollos Hermanos 2")
      menu = Menu.create(name: "test menu", restaurant_id: restaurant.id)
      item = Item.create(name: "test-item22")
      menu_item = MenuItem.create!(price: 10, menu_id: menu.id, item_id: item.id)

      # Create a new unique item to avoid duplication
      new_item = Item.create(name: "unique-test-item")

      post api_v1_menu_items_path, params: { menu_item: { price: 10, menu_id: menu.id, item_id: new_item.id } }

      expect(response).to have_http_status(:created) # 201

      json_response = JSON.parse(response.body)
      # puts json_response["details"]
      expect(json_response["menu_item"]["price"]).to eq("10.0")
    end

    it "create a empty price menu item" do
      restaurant = Restaurant.create(name: "Los Pollos Hermanos 3")
      menu = Menu.create(name: "test menu", restaurant_id: restaurant.id)
      item = Item.create(name: "test-item")
      menu_item = MenuItem.create!(price: 10, menu_id: menu.id, item_id: item.id)

      post api_v1_menu_items_path, params: { menu_item: { menu_id: menu.id, item_id: item.id } }
      expect(response).to have_http_status(:unprocessable_entity) # 422

      # json_response = JSON.parse(response.body)
      json_response = JSON.parse(response.body)
      expect(json_response["details"]).to include("Price can't be blank")
    end

    it "create a menu item without menu id" do
      # menu = Menu.create(name: "test")
      post api_v1_menu_items_path, params: { menu_item: { name: "test-no-id" } }
      expect(response).to have_http_status(:unprocessable_entity) # 422

      json_response = JSON.parse(response.body)
      expect(json_response["details"]).to include("Menu must exist")
    end
  end

# patch
describe "PATCH /menu_items/:id" do
  it "updates an existing menu item" do
    restaurant = Restaurant.create(name: "Los Pollos Hermanos 4")
    menu = Menu.create(name: "test menu", restaurant_id: restaurant.id)
    item = Item.create(name: "test-item")
    menu_item = MenuItem.create!(price: 10, menu_id: menu.id, item_id: item.id)

    patch api_v1_menu_item_path(menu_item.id), params: { menu_item: { price: 20 } }

    expect(response).to have_http_status(:ok) # 200
    menu_item.reload
    json_response = JSON.parse(response.body)
    expect(json_response["price"]).to eq("20.0")
    # expect(menu_item.name).to eq(20)
  end

  it "fails to update an existing menu item with invalid name" do
    restaurant = Restaurant.create(name: "Los Pollos Hermanos 4")
    menu = Menu.create(name: "test menu", restaurant_id: restaurant.id)
    item = Item.create(name: "test-item")
    menu_item = MenuItem.create!(price: 10, menu_id: menu.id, item_id: item.id)

    patch api_v1_menu_item_path(menu_item.id), params: { menu_item: { price: "" } }

    expect(response).to have_http_status(:unprocessable_entity) # 422
    menu_item.reload
    json_response = JSON.parse(response.body)
    expect(json_response["details"]).to include("Price can't be blank")
  end
end

# delete
describe "DELETE /menu_items/:id" do
  it "deletes an existing menu item" do
    restaurant = Restaurant.create(name: "Los Pollos Hermanos 6")
    menu = Menu.create(name: "test menu", restaurant_id: restaurant.id)
    item = Item.create(name: "test-item")
    menu_item = MenuItem.create!(price: 10, menu_id: menu.id, item_id: item.id)

    delete api_v1_menu_item_path(menu_item.id)

    expect(response).to have_http_status(:ok) # 200
    expect(MenuItem.exists?(menu_item.id)).to be_falsey
  end
end
end
