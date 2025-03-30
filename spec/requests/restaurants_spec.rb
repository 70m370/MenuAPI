require 'rails_helper'

RSpec.describe "/restaurants/ endpoint", type: :request do
  describe "GET /restaurants" do
    # show
    it "show all restaurants" do
      get api_v1_restaurants_path
      expect(response).to have_http_status(:ok) # 200
    end
  end

  # index
  describe "GET /restaurants/:id" do
    it "get restaurants by id" do
      restaurant = Restaurant.create(name:"Los Pollos Hermanos")
      get api_v1_restaurants_path(restaurant.id)
      expect(response).to have_http_status(:ok) # 200
      # return object
      expect(response.body).to include restaurant.name
    end

    it "Return restaurant not found" do
      get api_v1_restaurant_path(99) 
      expect(response).to have_http_status(:not_found) # 404
    end
  end

  # post
  describe "POST /restaurants/" do
    # create
    it "create a restaurants" do
      restaurant = Restaurant.create(name:"Robot Pollos")
      post api_v1_restaurants_path, params: { restaurant: { name: "Robot Pollos"} }
      expect(response).to have_http_status(:created) # 201
      expect(response.body).to include(restaurant.name)
    end

    it "create a empty restaurant" do
      restaurant = Restaurant.create(name:"")
      post api_v1_restaurants_path, params: { restaurant: { name: ""}}
      expect(response).to have_http_status(:unprocessable_entity) # 422
      expect(response.body).to include(restaurant.name)
    end
  end

  # patch
  describe "PATCH /restaurants/" do
    # update
    it "update a existing restaurants" do
      restaurant = Restaurant.create(name:"Restaurant")
      patch api_v1_restaurant_path(restaurant.id), params: { restaurant: { name: "updated Restaurant"} }
      expect(response).to have_http_status(:ok) # 200
      restaurant.reload
      expect(restaurant.name).to eq("updated Restaurant")
    end

    it "update a restaurants that doesnt exist" do
      restaurant = Restaurant.create(name:"Restaurant")
      patch api_v1_restaurant_path(restaurant.id), params: { restaurant: { name: ""} }
      expect(response).to have_http_status(:unprocessable_entity) # 422
      restaurant.reload
      expect(restaurant.name).to eq("Restaurant")
    end
  end

  # delete
  describe "DELETE /restaurant/" do
    # delete
    it "delete a existing restaurant" do
      restaurant = Restaurant.create(name:"Ashes Restaurant")
      delete api_v1_restaurant_path(restaurant.id)
      expect(response).to have_http_status(:ok) #200
      expect(Restaurant.exists?(restaurant.id)).to be_falsey
    end
  end
end
