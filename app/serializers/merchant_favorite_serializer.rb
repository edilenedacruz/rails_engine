class MerchantFavoriteSerializer < ActiveModel::Serializer
  attributes :favorite
  def favorite
    object.favorite_customer
  end
end
