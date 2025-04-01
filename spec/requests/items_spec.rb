require 'rails_helper'

RSpec.describe "/items/ endpoint", type: :request do
  describe "GET /items" do
    # show
    it "show all items" do
      get api_v1_items_path
      expect(response).to have_http_status(:ok) # 200
    end
  end

  # index
  describe "GET /items/:id" do
    it "get items by id" do
      item = Item.create(name: "test-item")
      get api_v1_items_path(item.id)
      expect(response).to have_http_status(:ok) # 200
      # return object
      expect(response.body).to include item.name
    end

    it "Return items not found" do
      get api_v1_item_path(99)
      expect(response).to have_http_status(:not_found) # 404
    end
  end

  # post
  describe "POST /items/" do
    # create
    it "create a item" do
      post api_v1_items_path, params: { item: { name: "test-item" } }
      expect(response).to have_http_status(:created) # 201
      json_response = JSON.parse(response.body)
      expect(json_response["item"]["name"]).to eq("test-item")
    end

    it "create a empty item" do
      post api_v1_items_path, params: { item: { name: "" } }
      expect(response).to have_http_status(:unprocessable_entity) # 422
      expect(response.body).to include("Name can't be blank")
    end
  end

  # patch
  describe "PATCH /items/" do
    # update
    it "update a existing item" do
      item = Item.create(name: "test-item")
      patch api_v1_item_path(item.id), params: { item: { name: "updated item" } }
      expect(response).to have_http_status(:ok) # 200
      item.reload
      expect(item.name).to eq("updated item")
    end

    it "update a item that doesnt exist" do
      item = Item.create!(name: "test-item")
      patch api_v1_item_path(item.id), params: { item: { name: "" } }
      expect(response).to have_http_status(:unprocessable_entity) # 422
      item.reload
      expect(item.name).to eq("test-item")
    end
  end

  # delete
  describe "DELETE /items/" do
    # delete
    it "delete a existing item" do
      item = Item.create!(name: "test-item")
      delete api_v1_item_path(item.id)
      expect(response).to have_http_status(:ok) # 200
      expect(Item.exists?(item.id)).to be_falsey
    end
  end
end
