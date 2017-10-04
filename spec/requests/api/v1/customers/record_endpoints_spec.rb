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

  it "can search a customer by its id" do
    data_customer = Fabricate(:customer)

    get "/api/v1/customers/find?id=#{data_customer.id}"

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer["id"]).to eq(data_customer.id)
  end

  it "can search a customer by its first name" do
    data_customer = Fabricate(:customer)

    get "/api/v1/customers/find?first_name=#{data_customer.first_name}"

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer["first_name"]).to eq(data_customer.first_name)
  end

    it "can search a customer by its first name, case insensitive" do
    data_customer = Fabricate(:customer, first_name: "Sweet Sauce")

    get "/api/v1/customers/find?first_name=SWEET SAUCE"

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer["first_name"]).to eq("Sweet Sauce")
  end

  it "can search a customer by its last name" do
    data_customer = Fabricate(:customer)

    get "/api/v1/customers/find?last_name=#{data_customer.last_name}"

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer["last_name"]).to eq(data_customer.last_name)
  end

  it "can search a customer by its last name, case insensitive" do
    data_customer = Fabricate(:customer, last_name: "Sweet Sauce")

    get "/api/v1/customers/find?last_name=sweet SAUCE"

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer["last_name"]).to eq("Sweet Sauce")
  end

  it "can search a customer by the date it was created at" do
    data_customer = Fabricate(:customer, created_at: "2017-03-16 23:58:29")

    get "/api/v1/customers/find?created_at=#{data_customer.created_at}"
    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer["id"]).to eq(data_customer.id)
  end

  it "can search a customer by the date it was updated at" do
    data_customer = Fabricate(:customer, updated_at: "2017-03-16 23:58:29")

    get "/api/v1/customers/find?updated_at=#{data_customer.updated_at}"

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer["id"]).to eq(data_customer.id)
  end

  it "can find a random customer" do
    data_customers = Fabricate.times(50, :customer)

    get '/api/v1/customers/random'

    expect(response).to be_success
    customer_1 = JSON.parse(response.body)
    data_customer_2 = Customer.find(customer_1["id"])

    get '/api/v1/customers/random'

    expect(response).to be_success
    customer_2 = JSON.parse(response.body)
    data_customer_2 = Customer.find(customer_2["id"])

    expect(customer_1).to_not eq(customer_2)
  end

  it "can find all customers by provided first name" do
  data_customer_1, data_customer_2 = Fabricate.times(2, :customer)

  get "/api/v1/customers/find_all?first_name=#{data_customer_1.first_name}"

  expect(response).to be_success

  customer_1 = JSON.parse(response.body).first

  expect(customer_1["first_name"]).to eq(data_customer_1.first_name)
end

  it "can find all customers by provided last name" do
    data_customer_1, data_customer_2 = Fabricate.times(2, :customer)

    get "/api/v1/customers/find_all?last_name=#{data_customer_1.last_name}"

    expect(response).to be_success

    customer_1 = JSON.parse(response.body).first

    expect(customer_1["last_name"]).to eq(data_customer_1.last_name)
  end
end
