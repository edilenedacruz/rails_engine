Fabricator(:item) do
  name { Faker::Lorem.word }
  description "Sunshine and whiskey"
  unit_price 5000
  merchant
end
