class MerchantDayRevenueSerializer < ActiveModel::Serializer
  attributes :revenue

  def revenue
    to_currency(object.revenue(@instance_options[:date]))
  end

  def to_currency(amount)
    amount.to_s.chars.insert(-3, ".").join
  end
end
