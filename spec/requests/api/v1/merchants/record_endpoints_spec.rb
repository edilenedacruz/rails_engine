require 'rails_helper'

describe "merchants API" do
  it "sends a list of merchants" do
      Fabricate.times(3, :merchant)
      get '/api/v1/merchants.json'

      expect(response).to be_success

      merchants = JSON.parse(response.body)

      expect(merchants.count).to eq(3)
  end

  it "can get one merchant by id" do
    id = Fabricate(:merchant).id

    get "/api/v1/merchants/#{id}.json"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(id)
  end
end
