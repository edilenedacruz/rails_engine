class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def format_price(unit_price)
    (unit_price.to_f * 100).round(2).to_i
  end

  def format_to_currency(unit_price)
    (unit_price / 100.00).round(2).to_s
  end

end
