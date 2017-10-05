require 'rails_helper'

describe "Items API Relationship" do
  it "returns a collection of associated invoice items" do
    item = Fabricate(:item)
    invoice_items = Fabricate.times(3, :invoice_item, item: item)

    get "/api/v1/items/#{item.id}/invoice_items"
    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(3)
    expect(invoice_items.first["item_id"]).to eq(item.id)
  end

  it "returns the associated merchant" do
    item = Fabricate(:item)

    get "/api/v1/items/#{item.id}/merchant"
    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(item.merchant.id)
  end
end
