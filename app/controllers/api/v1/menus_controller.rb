
class Api::V1::MenusController < ApplicationController
  before_action :set_menu, only: %i[ show update destroy ]

  # GET /menus
  def index
    @menus = Menu.all

    render json: @menus
  end

  # GET /menus/1
  def show
    render json: @menu
  end

  # POST /menus
  def create
    @menu = Menu.new(menu_params)

    if @menu.save
      render json: { message: "Menu created successfully", menu: @menu }, status: :created
    else
      raise ActiveRecord::RecordInvalid, @menu
    end
  rescue ActiveRecord::RecordInvalid => e
    handle_record_invalid(e)
  end

  # PATCH/PUT /menus/1
  def update
    if @menu.update(menu_params)
      render json: @menu
    else
      raise ActiveRecord::RecordInvalid, @menu
    end
  rescue ActiveRecord::RecordInvalid => e
    handle_record_invalid(e)
  end

  # DELETE /menus/1
  def destroy
    @menu.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    rescue StandardError => e
      handle_record_not_found(e)
    end

    # Only allow a list of trusted parameters through.
    def menu_params
      params.require(:menu).permit(:name)
    end
end
