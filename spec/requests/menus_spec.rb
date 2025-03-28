require 'rails_helper'

# show
RSpec.describe "Menus API", type: :request do
  describe "GET /menus" do
    it "renders a successful response" do
      get api_v1_menus_path
      expect(response).to have_http_status(:ok)
    end
  end

  # index
  describe "GET /menus/:id" do
    it "renders a successful response" do
      menu = Menu.create(name: "test menu")
      get api_v1_menus_path(menu.id)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include menu.name
    end
  end
end
