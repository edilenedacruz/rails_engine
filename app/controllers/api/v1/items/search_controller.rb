class Api::V1::Items::SearchController < ApplicationController

  def index
    render json: Item.where(item_params)
  end

  def show
    if params[:unit_price]
      render json: Item.find_by(unit_price: params[:unit_price].delete("."))
    else
      render json: Item.find_by(item_params)
    end
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
