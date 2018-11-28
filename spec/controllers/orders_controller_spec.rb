require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe '#create' do
    let(:action) { post :create, params: params }
    let(:params) { { order: { quote_id: quote_id } } }

    context 'successful' do
      let(:quote) { create(:quote) }
      let(:quote_id) { quote.id }

      it 'returns 201' do
        action
        expect(response).to have_http_status(201)
      end
    end

    context 'quote does not exist' do
      let(:quote_id) { 999 }

      it 'returns 404' do
        action
        expect(response).to have_http_status(404)
      end
    end
  end
end
