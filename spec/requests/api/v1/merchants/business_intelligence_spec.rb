require 'rails_helper'

describe "Merchants API" do
  it "returns the top x merchants ranked by total revenue" do
    merchant_1, merchant_2, merchant_3 = Fabricate.times(3, :merchant)
    customer = Fabricate(:customer)

    merchant_1_invoices = Fabricate.times(3, :invoice, customer: customer, merchant: merchant_1)
    merchant_1_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice)
    end

    merchant_2_invoices = Fabricate.times(2, :invoice, customer: customer, merchant: merchant_2)
    merchant_2_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice)
    end

    merchant_3_invoices = Fabricate.times(1, :invoice, customer: customer, merchant: merchant_3)
    merchant_3_invoices.each do |invoice|
       Fabricate(:invoice_item, invoice: invoice)
       Fabricate(:transaction, invoice: invoice)
     end

    get "/api/v1/merchants/most_revenue?quantity=2"

    expect(response).to be_success

    top_merchants = JSON.parse(response.body)

    expect(top_merchants.count).to eq(2)
    expect(top_merchants.first["id"]).to eq(merchant_1.id)
    expect(top_merchants.last["id"]).to_not eq(merchant_3.id)
    expect(top_merchants.last["id"]).to eq(merchant_2.id)
  end

  it "returns the top x merchants ranked by total number of items sold" do
    merchant_1, merchant_2, merchant_3 = Fabricate.times(3, :merchant)

    item_1, item_2, item_3 = Fabricate.times(3, :item)

    invoice_1 = Fabricate.times(7, :invoice, merchant: merchant_1)
    invoice_2 = Fabricate.times(7, :invoice, merchant: merchant_2)
    invoice_3 = Fabricate.times(7, :invoice, merchant: merchant_3)

    invoice_1.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice, quantity: 10, item: item_1)
      Fabricate(:transaction, invoice: invoice)
    end

    invoice_2.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice, quantity: 5, item: item_2)
      Fabricate(:transaction, invoice: invoice)
    end

    invoice_3.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice, quantity: 2, item: item_3)
      Fabricate(:transaction, invoice: invoice)
    end

    get '/api/v1/merchants/most_items?quantity=10'

    expect(response).to be_success

    merchants = JSON.parse(response.body)

    expect(merchants.first["id"]).to eq(merchant_1.id)
    expect(merchants.last["id"]).to eq(merchant_3.id)
  end

  it "returns the total revenue for date x across all merchants" do
    date_1 = "2017-10-04 10:32:39"
    date_2 = "2017-01-04 10:32:39"


    item_1 = Fabricate(:item, unit_price: 100)
    item_2 = Fabricate(:item, unit_price: 500)

    invoice_1 = Fabricate.times(3, :invoice, created_at: date_2, updated_at: date_2)
    invoice_2 = Fabricate.times(3, :invoice, created_at: date_1, updated_at: date_1)

    invoice_1.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice, quantity: 2, unit_price: 100, item: item_1)
      Fabricate(:transaction, invoice: invoice)
    end

    invoice_2.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice, quantity: 10, unit_price: 500, item: item_2)
      Fabricate(:transaction, invoice: invoice)
    end

    get "/api/v1/merchants/revenue?date=#{date_2}"

    expect(response).to be_success
    total_revenue = JSON.parse(response.body)
    expect(total_revenue).to eq(20000.0)
  end
end
