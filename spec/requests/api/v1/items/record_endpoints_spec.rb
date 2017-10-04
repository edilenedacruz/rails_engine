require 'rails_helper'

describe "items API" do
  it "sends a list of items" do
      Fabricate.times(3, :item)
      get '/api/v1/items.json'

      expect(response).to be_success

      items = JSON.parse(response.body)

      expect(items.count).to eq(3)
  end

end
