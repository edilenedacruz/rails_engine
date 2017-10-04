class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    if params[:unit_price]
      render json: InvoiceItem.find_by(unit_price: format_price(params[:unit_price]))
    else
      render json: InvoiceItem.find_by(invoice_item_params)
    end
  end

  private

  def invoice_item_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end
