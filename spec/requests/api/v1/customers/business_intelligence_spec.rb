require 'rails_helper'

describe "Customers Business Intelligence" do
  scenario "returns a merchant where the customer has conducted the most successful transactions" do
    customer = Fabricate(:customer)
    merchant_1 = Fabricate(:merchant)
    merchant_2 = Fabricate(:merchant)
    invoice_1 = Fabricate(:invoice, customer: customer, merchant: merchant_1)
    invoice_2 = Fabricate(:invoice, customer: customer, merchant: merchant_1)
    invoice_3 = Fabricate(:invoice, customer: customer, merchant: merchant_1)
    invoice_4 = Fabricate(:invoice, customer: customer, merchant: merchant_2)
    transaction_1 = Fabricate(:transaction, invoice: invoice_1, result: "success")
    transaction_2 = Fabricate(:transaction, invoice: invoice_2, result: "success")
    transaction_3 = Fabricate(:transaction, invoice: invoice_3, result: "success")
    transaction_4 = Fabricate(:transaction, invoice: invoice_4, result: "success")

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    customer_bi = JSON.parse(response.body)
    expect(response).to be_success
    expect(customer.favorite_merchant).to eq(merchant_1)

  end
end
