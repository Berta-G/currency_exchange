class QuotesController < ApplicationController
  def create
    result = Quotes::Create.(quote_params)

    if result.right?
      render json: result.value, status: 201
    else
      render json: { error: result.value }, status: 422
    end
  end

  def quote_params
    params.require(:quote).permit(:currency_id, :requested_value)
  end
end
