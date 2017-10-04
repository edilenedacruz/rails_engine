require 'rails_helper'


describe "customers API" do
  it "sends a list of customers" do
      Fabricate.times(3, :customer)
      get '/api/v1/customers.json'

      expect(response).to be_success

      customers = JSON.parse(response.body)

      expect(customers.count).to eq(3)
  end

  it "can get one customers by id" do
    id = Fabricate(:customer).id

    get "/api/v1/customers/#{id}.json"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer["id"]).to eq(id)
  end
end
