require 'rails_helper'

describe "transactions API" do
  it "sends a list of transactions" do
      Fabricate.times(3, :transaction)
      get '/api/v1/transactions.json'

      expect(response).to be_success

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(3)
  end

end
