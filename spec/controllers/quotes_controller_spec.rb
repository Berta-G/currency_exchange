require 'rails_helper'

RSpec.describe QuotesController, type: :controller do
  describe '#create' do
    let(:action) { post :create, params: params }
    let(:params) do { quote: { requested_value: requested_value,
                               currency_id: currency_id } }
    end
    let(:requested_value) { 100 }

    context 'successful' do
      let(:currency) { create(:currency) }
      let(:currency_id) { currency.id }

      it 'returns 201' do
        action
        expect(response).to have_http_status(201)
      end
    end

    context 'currency does not exist' do
      let(:currency_id) { 999 }

      it 'returns 404' do
        action
        expect(response).to have_http_status(404)
      end
    end
  end
end
