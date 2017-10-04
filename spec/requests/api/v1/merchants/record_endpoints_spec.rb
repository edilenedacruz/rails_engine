require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
      Fabricate.times(3, :merchant)

      get '/api/v1/merchants'

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


  it "finds a merchant by its name" do
    data_merchant = Fabricate(:merchant)

    get "/api/v1/merchants/find?name=#{data_merchant.name}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant["name"]).to eq("#{data_merchant.name}")
  end

  it "finds a merchant by its name, case insensitive" do
    data_merchant = Fabricate(:merchant, name: "We The Best")

    get "/api/v1/merchants/find?name=we the best"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant["name"]).to eq("We The Best")
  end
end
