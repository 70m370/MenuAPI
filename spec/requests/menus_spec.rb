require 'rails_helper'

RSpec.describe "/menus/ endpoint", type: :request do
  describe "GET /menus" do
    # show
    it "show all menus" do
      get api_v1_menus_path
      expect(response).to have_http_status(:ok) # 200
    end
  end

  # index
  describe "GET /menus/:id" do
    it "get menu by id" do
      menu = Menu.create(name: "test menu")
      get api_v1_menus_path(menu.id)
      expect(response).to have_http_status(:ok) # 200
      # return object
      expect(response.body).to include menu.name
    end

    it "Return menu not found" do
      get api_v1_menu_path(99) #  api_v1_menu GET    /api/v1/menus/:id(.:format)
      expect(response).to have_http_status(:not_found) # 404
    end
  end

  # post
  describe "POST /menus/" do
    # create
    it "create a menu" do
      menu = Menu.create(name: "test-menu")
      post api_v1_menus_path, params: { menu: { name: "test-menu" } }
      expect(response).to have_http_status(:created) # 201
      expect(response.body).to include(menu.name)
    end

    it "create a empty name menu" do
      menu = Menu.create(name: "")
      post api_v1_menus_path, params: { menu: { name: "" } }
      expect(response).to have_http_status(:unprocessable_entity) # 422
      expect(response.body).to include(menu.name)
    end
  end

  # patch
  describe "PATCH /menu/" do
    # update
    it "update a existing menu" do
      menu = Menu.create(name: "menu")
      patch api_v1_menu_path(menu.id), params: { menu: { name: "updated menu" } }
      expect(response).to have_http_status(:ok) # 200
      menu.reload
      expect(menu.name).to eq("updated menu")
    end

    it "update a existing menu" do
      menu = Menu.create(name: "menu")
      patch api_v1_menu_path(menu.id), params: { menu: { name: "" } }
      expect(response).to have_http_status(:unprocessable_entity) # 422
      menu.reload
      expect(menu.name).to eq("menu")
    end
  end

  # delete
  describe "DELETE /menu/" do
    # delete
    it "delete a existing menu" do
      menu = Menu.create(name: "menu")
      delete api_v1_menu_path(menu.id)
      expect(response).to have_http_status(:no_content) # 204
      expect(Menu.exists?(menu.id)).to be_falsey
    end
  end
end
