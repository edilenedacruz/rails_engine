Fabricator(:item) do
  name { Faker::Lorem.word }
  description "Sunshine and whiskey"
  unit_price 5055
  merchant
end
