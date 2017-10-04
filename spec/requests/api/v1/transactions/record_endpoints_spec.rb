require 'rails_helper'

describe "Transactions API" do
  it "sends a list of transactions" do
      Fabricate.times(3, :transaction)

      get '/api/v1/transactions'

      expect(response).to be_success

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(3)
  end

  it "can get one transaction by id" do
    id = Fabricate(:transaction).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["id"]).to eq(id)
  end

  it "finds a transaction by its id" do
    data_transaction = Fabricate(:transaction)

    get "/api/v1/transactions/find?id=#{data_transaction.id}"

    expect(response).to be_success

    transaction = JSON.parse(response.body)

    expect(transaction["id"]).to eq(data_transaction.id)
  end

  it "can find first instance by created_at" do
    invoice = Fabricate(:invoice)
    data_transaction = Fabricate(:transaction, created_at: "2012-03-27T14:54:05.000Z", invoice: invoice)

    get "/api/v1/transactions/find?created_at=2012-03-27T14:54:05.000Z"

    expect(response).to be_success

    transaction = JSON.parse(response.body)

    expect(data_transaction.id).to eq(transaction["id"])
  end

  it "can find all transactions by providing an invoice_id" do
    data_transaction_1, data_transaction_2 = Fabricate.times(2, :transaction)

    get "/api/v1/transactions/find_all?id=#{data_transaction_1.id}"

    expect(response).to be_success

    transaction_1 = JSON.parse(response.body).first

    expect(transaction_1["id"]).to eq(data_transaction_1.id)
  end

  it "can find a random transaction" do
    data_merchants = Fabricate.times(50, :transaction)

    get '/api/v1/transactions/random'

    expect(response).to be_success
    transaction_1 = JSON.parse(response.body)
    data_transaction_2 = Transaction.find(transaction_1["id"])

    get '/api/v1/transactions/random'

    expect(response).to be_success
    transaction_2 = JSON.parse(response.body)
    data_transaction_2 = Transaction.find(transaction_2["id"])

    expect(transaction_1).to_not eq(transaction_2)
  end

  it "can find all instances by updated at" do
    data_transactions = Fabricate.times(7, :transaction, updated_at: "2012-03-27T14:56:42.000Z9")

    get "/api/v1/transactions/find_all?updated_at=2012-03-27T14:56:42.000Z"

    expect(response).to be_success

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(7)
  end
end
