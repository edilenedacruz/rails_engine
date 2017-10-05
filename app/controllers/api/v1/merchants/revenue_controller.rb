class Api::V1::Merchants::RevenueController < ApplicationController
  def most_revenue
    render json: Merchant.most_revenue(params[:quantity])
  end

  def most_items
    render json: Merchant.most_items(params[:quantity])
  end

  def date_total
    render json: format_price(Merchant.date_total_revenue(params[:date]))
  end
end
