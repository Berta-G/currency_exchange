module Orders
  module Create
    extend self

    def call(params)
      quote = Quote.find(params[:quote_id])
      goal_value = quote.offered_value

      create_order(quote: quote, goal_value: goal_value)
    end

    private

    def create_order(quote:, goal_value:)
      Quotes::BestApproximation.(currency: quote.currency,
                                 goal_value: goal_value).bind do |approx|

        if approx[:value] != goal_value
          return Either.left("Could Not fulfill Order")
        end

        persist_order_with_denominations(quote: quote, approx_denominations: approx[:denominations])
      end
    end

    def persist_order_with_denominations(quote:, approx_denominations:)
      Order.transaction do
        order = Order.create!(quote_id: quote.id, status: 'completed')
        create_order_denominations(order, approx_denominations: approx_denominations)
        update_denominations_stock(approx_denominations: approx_denominations)

        order ? Either.right(order) : Either.left(order.errors.full_message)
      end
    end

    def create_order_denominations(order, approx_denominations:)
      approx_denominations.each do |approx_denomination|
        OrderDenomination.create!(order: order,
                                  denomination_id: approx_denomination[:id],
                                  amount: approx_denomination[:amount])
      end
    end

    def update_denominations_stock(approx_denominations:)
      approx_denominations.each do |approx_denomination|
        denomination = Denomination.find(approx_denomination[:id])
        denomination.amount -= approx_denomination[:amount]
        denomination.save!
      end
    end
  end
end