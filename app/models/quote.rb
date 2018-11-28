class Quote < ApplicationRecord
  belongs_to :currency

  validates :requested_value, numericality: { greater_than: 0 }
  validates :offered_value, numericality: { greater_than: 0 }
end
