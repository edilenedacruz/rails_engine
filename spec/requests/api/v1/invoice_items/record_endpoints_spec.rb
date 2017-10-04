require 'rails_helper'

describe "invoice_items API" do
  it "sends a list of invoice_items" do
      Fabricate.times(3, :invoice_item)
      get '/api/v1/invoice_items.json'

      expect(response).to be_success

      invoice_items = JSON.parse(response.body)

      expect(invoice_items.count).to eq(3)
  end

end
