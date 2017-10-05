class Api::V1::Merchants::RevenueController < ApplicationController
  def most_revenue
    render json: Merchant.most_revenue(params[:quantity])
  end

  def most_items
    render json: Merchant.most_items(params[:quantity])
  end

  def date_total
    total = format_to_currency(Merchant.date_total_revenue(params[:date]))
    render json: { "total_revenue" => total }
  end
end
