class Api::V1::Merchants::MerchantRevenueController < ApplicationController
  def show
    render json: Merchant.find(params[:id]), serializer: MerchantDayRevenueSerializer, date: params[:date]
  end
end
