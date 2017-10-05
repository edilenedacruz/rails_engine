class Api::V1::Merchants::FavoriteController < ApplicationController
  def show
    render json: Merchant.find(params[:id]), serializer: MerchantFavoriteSerializer
  end
end
