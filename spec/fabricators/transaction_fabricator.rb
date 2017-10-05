Fabricator(:transaction) do
  invoice
  credit_card_number { Faker::Business.credit_card_number }
  result { %w(success failed).sample }
end
