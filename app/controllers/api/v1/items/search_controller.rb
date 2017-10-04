class Api::V1::Items::SearchController < ApplicationController
  def show
    if params[:unit_price]
      render json: Item.find_by(unit_price: format_price(params[:unit_price]))
    else
      render json: Item.find_by(item_params)
    end
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
