require 'rails_helper'

describe "items API" do
  it "sends a list of items" do
      Fabricate.times(3, :item)
      get '/api/v1/items.json'

      expect(response).to be_success

      items = JSON.parse(response.body)

      expect(items.count).to eq(3)
  end

  it "can get one item by its id" do
    id = Fabricate(:item).id

    get "/api/v1/items/#{id}.json"

    expect(response).to be_success

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(id)
  end
end
