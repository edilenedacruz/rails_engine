require 'rails_helper'

describe "invoice_items API" do
  it "sends a list of invoice_items" do
      Fabricate.times(3, :invoice_item)
      get '/api/v1/invoice_items.json'

      expect(response).to be_success

      invoice_items = JSON.parse(response.body)

      expect(invoice_items.count).to eq(3)
  end

  it "can get one invoice item by its id" do
    id = Fabricate(:invoice_item).id

    get "/api/v1/invoice_items/#{id}.json"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["id"]).to eq(id)
  end
end
