module Orders
  module Create
    extend self

    def call(params)
      quote = Quote.find(params[:quote_id])
      goal_value = quote.offered_value

      Quotes::BestApproximation.(currency: quote.currency,
                         goal_value: goal_value).bind do |approx|

        if approx[:value] != goal_value
          return Either.left("Could Not fulfill Order")
        end

        Order.transaction do
          order = Order.create(quote_id: quote.id, status: 'completed')

          approx[:denominations].each do |denomination|
            OrderDenomination.create(order: order,
                                     denomination_id: denomination[:id],
                                     amound: denomination[:avmount])
          end

          order ? Either.right(order) : Either.left(order.errors.full_message)
        end
      end
    end
  end
end