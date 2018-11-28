module Quotes
  module Create
    extend self

    def call(params)
      currency = Currency.find(params[:currency_id])
      goal_value = params[:requested_value].to_i

      create_quote(currency: currency, goal_value: goal_value)
    end

    private

    def create_quote(currency:, goal_value:)
      BestApproximation.(currency: currency,
                         goal_value: goal_value).bind do |approx|
        quote = Quote.new(currency_id: currency.id,
                          requested_value: goal_value,
                          offered_value: approx[:value],
                          exchange_rate: currency.exchange_rate)
        quote.save ? Either.right(quote) : Either.left(quote.errors.full_messages)
      end
    end
  end
end