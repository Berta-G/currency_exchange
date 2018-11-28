module Quotes
  module BestApproximation
    extend self
    def call(goal_value:, currency:)

      Either.right(total: goal_value, denominations: [])
    end
  end
end