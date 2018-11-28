module Quotes
  module Create
    extend self

    def call(params)
      currency = Currency.find(params[:currency_id])
      requested_value = params[:requested_value]

      BestApproximation.(currency: currency,
                         goal_value: requested_value).bind do |approx|

        offered_value = approx[:value]

        quote = Quote.create(currency_id: currency.id,
                             requested_value: requested_value,
                             offered_value: approx[:value],
                             exchange_rate: currency.exchange_rate)

        quote ? Either.right(quote) : Either.left(quote.errors.full_message)
      end
    end
  end
end