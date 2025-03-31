class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show update destroy ]

  # GET /items
  def index
    @items = Item.all

    render json: @items
  end

  # GET /items/1
  def show
    render json: @item
  end

  # POST /items
  def create
    @item = Item.new(item_params)
    if @item.save
      render json: { message: "Item created successfully", item: @item }, status: :created
    else
      raise ActiveRecord::RecordInvalid, @item
    end
  rescue ActiveRecord::RecordInvalid => e
    handle_record_invalid(e)
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      render json: @item
    else
      raise ActiveRecord::RecordInvalid, @item
    end
  rescue ActiveRecord::RecordInvalid => e
    handle_record_invalid(e)
  end

  # DELETE /items/1
  def destroy
    @item.destroy!
    if @menu_item.destroy
      render json: { message: "successfully deleted" }, status: :ok
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params.expect(:id))
    rescue StandardError => e
      handle_record_not_found(e)
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:name)
    end
end
