class OrdersController < ApplicationController
  def create
    result = Orders::Create.(order_params)

    if result.right?
      render json: result.value, status: 201
    else
      render json: { error: result.value }, status: 422
    end
  end

  def order_params
    params.require(:order).permit(:quote_id)
  end
end
