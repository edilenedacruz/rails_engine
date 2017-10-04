require 'rails_helper'

describe "Items API" do
  it "creates a list of items" do
    Fabricate.times(5, :item)

    get '/api/v1/items.json'

    expect(response).to be_success

    items = JSON.parse(response.body)

    expect(items.count).to eq(5)
  end

  it "can get one item by its id" do
    id = Fabricate(:item).id

    get "/api/v1/items/#{id}.json"

    expect(response).to be_success

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(id)
  end

  it "can search an item by its id" do
    data_item = Fabricate(:item)

    get "/api/v1/items/find?id=#{data_item.id}"

    expect(response).to be_success

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(data_item.id)
  end

  it "can search an item by its name" do
    data_item = Fabricate(:item)

    get "/api/v1/items/find?name=#{data_item.name}"

    expect(response).to be_success

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["name"]).to eq(data_item.name)
  end

  it "can search an item by its description" do
    data_item = Fabricate(:item)

    get "/api/v1/items/find?description=#{data_item.description}"

    expect(response).to be_success

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["description"]).to eq(data_item.description)
  end

  it "can search an item by its unit price" do
    data_item = Fabricate(:item)
    item_price = "50.55"
    get "/api/v1/items/find?unit_price=#{item_price}"

    expect(response).to be_success

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["unit_price"]).to eq(data_item.unit_price)
  end

  it "can search an item by its merchant_id" do
    data_item = Fabricate(:item)

    get "/api/v1/items/find?merchant_id=#{data_item.merchant_id}"

    expect(response).to be_success

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["merchant_id"]).to eq(data_item.merchant_id)
  end

  it "can search an item by the date it was created at" do
    data_item = Fabricate(:item, created_at: "2017-03-16 23:58:29")

    get "/api/v1/items/find?created_at=#{data_item.created_at}"

    expect(response).to be_success

    item = JSON.parse(response.body)

    expect(item["id"]).to eq(data_item.id)
  end

  it "can search an item by the date it was updated at" do
    data_item = Fabricate(:item, updated_at: "2017-03-16 23:58:29")

    get "/api/v1/items/find?updated_at=#{data_item.updated_at}"

    expect(response).to be_success

    item = JSON.parse(response.body)

    expect(item["id"]).to eq(data_item.id)
  end
end
