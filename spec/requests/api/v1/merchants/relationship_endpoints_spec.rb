require 'rails_helper'

describe "Merchant Relationship Endpoint" do
  it "can return a collection of items associated with a merchant" do
    merchant = Fabricate(:merchant)
    items = Fabricate.times(10, :item, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_success
    merchant_items = JSON.parse(response.body)

    expect(merchant_items.count).to eq(10)
    expect(merchant.id).to eq(items.first.merchant_id)
    expect(merchant.id).to eq(items.last.merchant_id)
  end

  xit "can return a collection of invoices associated with a merchant from their known orders" do
    merchant = Fabricate(:merchant)
    invoices = Fabricate.times(32, :invoice, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/invoices"
    expect(response).to be_success
    merchant_invoices = JSON.parse(response.body)

    expect(merchant_invoices.count).to eq(32)
    expect(merchant.id).to eq(invoices.first.merchant_id)
    expect(merchant.id).to eq(invoices.last.merchant_id)
  end
end
