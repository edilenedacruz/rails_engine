require 'rails_helper'

describe "Merchants API" do
  it "returns the total revenue for that merchant across successful transactions" do
    merchant = Fabricate(:merchant)
    invoices = Fabricate.times(3, :invoice, merchant: merchant)
    invoices.each do |invoice|
      Fabricate.times(2, :invoice_item, invoice: invoice)
      Fabricate.times(3, :transaction, result: 'success', invoice: invoice)
    end

    get "/api/v1/merchants/#{merchant.id}/revenue"

    revenue = JSON.parse(response.body)

    expect(revenue["revenue"]).to eq("1800.00")
  end

  it "returns the total revenue for that merchant for a specific invoice date" do
    merchant = Fabricate(:merchant)
    invoices = Fabricate.times(5, :invoice, merchant: merchant, created_at: "2017-10-05 10:50:00")
    invoices.each do |invoice|
      Fabricate.times(2, :invoice_item, invoice: invoice)
      Fabricate.times(3, :transaction, result: 'success', invoice: invoice)
    end

    get "/api/v1/merchants/#{merchant.id}/revenue?date=2017-10-05 10:50:00"

    revenue = JSON.parse(response.body)

    expect(revenue["revenue"]).to eq("3000.00")
  end

  it "returns the customer who has conducted the most total number of successful transactions" do
    merchant = Fabricate(:merchant)
    customer_1, customer_2, customer_3 = Fabricate.times(3, :customer)
    invoice_1, invoice_2 = Fabricate.times(2, :invoice, merchant: merchant, customer: customer_1)
    invoice_3, invoice_4, invoice_5 = Fabricate.times(3, :invoice, merchant: merchant, customer: customer_2)
    invoice_6 = Fabricate(:invoice, merchant: merchant, customer: customer_3)
    Invoice.all.each do |invoice|
      Fabricate(:transaction, result: 'success', invoice: invoice)
    end

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    favorite = JSON.parse(response.body)["favorite"]
    expect(favorite["first_name"]).to eq(customer_2.first_name)
  end
end
