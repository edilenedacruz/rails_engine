require 'rails_helper'

describe "Invoice Items Relationship Endpoints" do
  it "returns the associated invoice" do
    invoice_item = Fabricate(:invoice_item)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"
    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(InvoiceItem.first.invoice.id)
  end

  it "returns the associated item for an invoice" do
    invoice_item = Fabricate(:invoice_item)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"
    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(InvoiceItem.first.item.id)
  end
end
