class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.random
    all.sample
  end
end
