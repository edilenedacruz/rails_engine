require 'rails_helper'

describe "invoices API" do
  it "sends a list of invoices" do
      Fabricate.times(3, :invoice)
      get '/api/v1/invoices.json'

      expect(response).to be_success

      invoices = JSON.parse(response.body)

      expect(invoices.count).to eq(3)
  end

end
