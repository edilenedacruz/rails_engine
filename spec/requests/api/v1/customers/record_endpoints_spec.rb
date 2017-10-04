require 'rails_helper'


describe "customers API" do
  it "sends a list of customers" do
      Fabricate.times(3, :customer)
      get '/api/v1/customers.json'

      expect(response).to be_success

      customers = JSON.parse(response.body)

      expect(customers.count).to eq(3)
  end

end
