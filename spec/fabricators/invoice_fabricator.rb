Fabricator(:invoice) do
  merchant
  customer
  status "shipped"
end
