Fabricator(:item) do
  name { Faker::Lorem.word }
  description "Sunshine and whiskey"
  unit_price 50055
  merchant
end
