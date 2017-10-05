class Api::V1::Merchants::UnpaidController < ApplicationController
  def index
    render json: Merchant.find(params[:id]).customers_with_pending_invoices
  end
end
