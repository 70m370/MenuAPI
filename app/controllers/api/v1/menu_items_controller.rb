class Api::V1::MenuItemsController < ApplicationController
  before_action :set_menu_item, only: %i[ show update destroy ]

  # GET /menu_items
  def index
    @menu_items = MenuItem.all

    render json: @menu_items
  end

  # GET /menu_items/1
  def show
    render json: @menu_item
  end

  # POST /menu_items
  def create
    @menu_item = MenuItem.new(menu_item_params)

    if @menu_item.save
      render json: { message: "Menu Item created successfully", menu_item: @menu_item }, status: :created
    else
      raise ActiveRecord::RecordInvalid, @menu_item
    end
  rescue ActiveRecord::RecordInvalid => e
    handle_record_invalid(e)
  end

  # PATCH/PUT /menu_items/1
  def update
    if @menu_item.update(menu_item_params)
      render json: @menu_item
    else
      raise ActiveRecord::RecordInvalid, @menu_item
    end
  rescue ActiveRecord::RecordInvalid => e
    handle_record_invalid(e)
  end

  # DELETE /menu_items/1
  def destroy
    @menu_item.destroy!
    if @menu_item.destroy
      render json: { message: "successfully deleted"}, status: :ok
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_item
      @menu_item = MenuItem.find(params[:id])
    rescue StandardError => e
      handle_record_not_found(e)
    end

    # Only allow a list of trusted parameters through.
    def menu_item_params
      params.require(:menu_item).permit(:name, :menu_id)
    end
end
