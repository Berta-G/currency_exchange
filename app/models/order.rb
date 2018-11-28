class Order < ApplicationRecord
  belongs_to :quote
  has_many :order_denominations
end
