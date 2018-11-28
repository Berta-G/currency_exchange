module Quotes
  module BestApproximation
    extend self
    def call(goal_value:, currency:)
      denominations = Denomination.available.where(currency: currency)
      up_to_value_approximation(goal_value: goal_value, denominations: denominations)
    end

    private

    def up_to_value_approximation(goal_value:, denominations:)
      approx_value = 0
      approx_denominations = []

      denominations.order(value: :desc).each do |denomination|
        wanted_amount = ((goal_value - approx_value) / denomination.value).to_i

        next unless wanted_amount > 0

        taken_amount = if denomination.amount >= wanted_amount
          wanted_amount
        else
          denomination.amount
        end

        approx_denominations << { id: denomination.id, amount: taken_amount }
        approx_value += denomination.value * taken_amount

        break if approx_value >= goal_value
      end

      Either.right( { value: approx_value, denominations: approx_denominations } )
    end
  end
end