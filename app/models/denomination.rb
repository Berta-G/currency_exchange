class Denomination < ApplicationRecord
  belongs_to :currency
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  scope :available, -> { where('amount > ?', 0) }
end
