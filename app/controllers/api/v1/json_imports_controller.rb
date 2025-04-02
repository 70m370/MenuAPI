class Api::V1::JsonImportsController < ApplicationController
  def create
    json_data = request.body.read
    return render json: { message: "No JSON data provided", log: [] }, status: :bad_request if json_data.blank?

    begin
      parsed_json = JSON.parse(json_data)
      log = process_json(parsed_json)
      render json: { message: "Import completed", log: log }, status: :ok
    rescue JSON::ParserError
      render json: { message: "Invalid JSON format", log: [] }, status: :unprocessable_entity
    rescue StandardError => e
      render json: { message: "Internal server error: #{e.message}", log: [] }, status: :internal_server_error
    end
  end

  private

  def process_json(json_data)
    log = { restaurants_created: 0, menus_created: 0, items_created: 0, errors: [] }

    # triple loop, need to think of efficiency here
    # first filter the restaurant
    json_data["restaurants"].each do |restaurant_data|
      restaurant = Restaurant.find_or_create_by!(name: restaurant_data["name"])
      log[:restaurants_created] += 1 if restaurant.previously_new_record?
      # filter menu
      restaurant_data["menus"].each do |menu_data|
        menu = restaurant.menus.find_or_create_by!(name: menu_data["name"])
        log[:menus_created] += 1 if menu.previously_new_record?
        # menu items
        items_key = menu_data["menu_items"] || menu_data["dishes"]
        next unless items_key
        # items inside menu being handled as names
        items_key.each do |item_data|
          item = Item.find_or_create_by!(name: item_data["name"])
          log[:items_created] += 1 if item.previously_new_record?
          MenuItem.find_or_create_by!(menu: menu, item: item, price: item_data["price"])
        rescue StandardError => e
          log[:errors] << { item: item_data, error: e.message }
        end
      end
    end
    # dont paste the json on the response
    log
  end
end
