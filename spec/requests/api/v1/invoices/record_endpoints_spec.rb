require 'rails_helper'

describe "Invoices API" do
  it "creates a list of invoices" do
    Fabricate.times(3, :invoice)

    get '/api/v1/invoices.json'

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(3)
  end

  it "can get one invoice by its id" do
    id = Fabricate(:invoice).id

    get "/api/v1/invoices/#{id}.json"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(id)
  end

  it "can search an invoice by its id" do
    data_invoice = Fabricate(:invoice)

    get "/api/v1/invoices/find?id=#{data_invoice.id}"

    expect(response).to be_success

    invoice = JSON.parse(response.body)

    expect(invoice["id"]).to eq(data_invoice.id)
  end

  it "can search an invoice by a customer id" do
    data_invoice = Fabricate(:invoice)

    get "/api/v1/invoices/find?customer_id#{data_invoice.customer_id}"

    expect(response).to be_success

    invoice = JSON.parse(response.body)

    expect(invoice["customer_id"]).to eq(data_invoice.customer_id)
  end

  it "can search an invoice by a merchant id" do
    data_invoice = Fabricate(:invoice)

    get "/api/v1/invoices/find?merchant_id#{data_invoice.merchant_id}"

    expect(response).to be_success

    invoice = JSON.parse(response.body)

    expect(invoice["merchant_id"]).to eq(data_invoice.merchant_id)
  end

  it "can search an invoice by provided status" do
    data_invoice = Fabricate(:invoice)

    get "/api/v1/invoices/find?status=#{data_invoice.status}"

    expect(response).to be_success

    invoice = JSON.parse(response.body)

    expect(invoice["status"]).to eq(data_invoice.status)
  end

  it "can search an invoice by provided status, case insensitive" do
    data_invoice = Fabricate(:invoice, status: "shipped")

    get "/api/v1/invoices/find?status=SHIpped"

    expect(response).to be_success

    invoice = JSON.parse(response.body)

    expect(invoice["status"]).to eq(data_invoice.status)
  end

  it "can search an invoice by the date it was created at" do
    data_invoice = Fabricate(:invoice, created_at: "2017-03-16 23:58:29")

    get "/api/v1/invoices/find?created_at=#{data_invoice.created_at}"

    expect(response).to be_success

    invoice = JSON.parse(response.body)

    expect(invoice["id"]).to eq(data_invoice.id)
  end

  it "can search an invoice by the date it was updated at" do
    data_invoice = Fabricate(:invoice, updated_at: "2017-03-16 23:58:29")

    get "/api/v1/invoices/find?updated_at=#{data_invoice.updated_at}"

    expect(response).to be_success

    invoice = JSON.parse(response.body)

    expect(invoice["id"]).to eq(data_invoice.id)
  end
end
