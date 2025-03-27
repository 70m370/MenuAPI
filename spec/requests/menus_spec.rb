require "rails_helper"

#
# menu tests
#

RSpec.describe "Menu Api", type: :request do
  describe "GET /menus" do
    it "return all menus" do
      Menu.create(name: "Lunch")

      get "/api/v1/menus"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end
end
