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

  it "can find a random invoice" do
    data_invoices = Fabricate.times(50, :invoice)

    get '/api/v1/invoices/random'

    expect(response).to be_success
    invoice_1 = JSON.parse(response.body)
    data_invoice_2 = Invoice.find(invoice_1["id"])

    get '/api/v1/invoices/random'

    expect(response).to be_success
    invoice_2 = JSON.parse(response.body)
    data_invoice_2 = Invoice.find(invoice_2["id"])

    expect(invoice_1).to_not eq(invoice_2)
  end

  it "can find all invoices by id" do
    data_invoice_1 = Fabricate(:invoice)

    get "/api/v1/invoices/find_all?id=#{data_invoice_1.id}"

    expect(response).to be_success

    invoice_1 = JSON.parse(response.body)

    expect(invoice_1[0]["id"]).to eq(data_invoice_1.id)
  end

  it "can find all invoices that belongs to an specific customer" do
    customer = Fabricate(:customer)
    data_invoice_1, data_invoice_2 = Fabricate.times(2, :invoice, customer: customer)

    get "/api/v1/invoices/find_all?customer_id=#{data_invoice_1.customer_id}"

    expect(response).to be_success

    invoice_1 = JSON.parse(response.body).first
    invoice_2 = JSON.parse(response.body).last

    expect(invoice_1["customer_id"]).to eq(data_invoice_1.customer_id)
    expect(invoice_2["customer_id"]).to eq(data_invoice_2.customer_id)
  end

  it "can find all invoices that belongs to an specific merchant" do
    merchant = Fabricate(:merchant)
    data_invoice_1, data_invoice_2 = Fabricate.times(2, :invoice, merchant: merchant)

    get "/api/v1/invoices/find_all?merchant_id=#{data_invoice_1.merchant_id}"

    expect(response).to be_success

    invoice_1 = JSON.parse(response.body).first
    invoice_2 = JSON.parse(response.body).last

    expect(invoice_1["merchant_id"]).to eq(data_invoice_1.merchant_id)
    expect(invoice_2["merchant_id"]).to eq(data_invoice_2.merchant_id)
  end

  it "can find all invoices by its status" do
    data_invoice_1, data_invoice_2 = Fabricate.times(2, :invoice)

    get "/api/v1/invoices/find_all?status=#{data_invoice_1.status}"

    expect(response).to be_success

    invoice_1 = JSON.parse(response.body).first
    invoice_2 = JSON.parse(response.body).last

    expect(invoice_1["status"]).to eq(data_invoice_1.status)
    expect(invoice_2["status"]).to eq(data_invoice_2.status)
  end
end
