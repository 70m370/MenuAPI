class Api::V1::RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[ show update destroy ]

  # GET /restaurants
  def index
    @restaurants = Restaurant.all

    render json: @restaurants, include: ['menus.menu_items']
  end

  # GET /restaurants/1
  def show
    render json: @restaurants, include: ['menus.menu_items']
  end

  # POST /restaurants
  def create
    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      render json: { message: "Restaurant created successfully", restaurant: @restaurant }, status: :created
    else
      raise ActiveRecord::RecordInvalid, @restaurant
    end
  rescue ActiveRecord::RecordInvalid => e
    handle_record_invalid(e)
  end

  # PATCH/PUT /restaurants/1
  def update
    if @restaurant.update(restaurant_params)
      render json: @restaurant
    else
      raise ActiveRecord::RecordInvalid, @restaurant
    end
  rescue ActiveRecord::RecordInvalid => e
    handle_record_invalid(e)
  end

  # DELETE /restaurants/1
  def destroy
    @restaurant.destroy!
    if @restaurant.destroy
      render json: { message: "successfully deleted"}, status: :ok
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params.expect(:id))
    rescue StandardError => e
      handle_record_not_found(e)
    end

    # Only allow a list of trusted parameters through.
    def restaurant_params
      params.require(:restaurant).permit(:name)
    end
end
