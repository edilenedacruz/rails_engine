class Api::V1::Invoices::RandomController < ApplicationController
  def show
    render json: Invoice.all.random
  end
end
