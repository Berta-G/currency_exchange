require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe '#create' do
    let(:action) { post :create, params: params }
    let(:params) { { order: { quote_id: quote_id } } }
    let(:quote) { create(:quote, offered_value: 90) }
    let(:quote_id) { quote.id }
    let(:currency) { quote.currency }

    context 'successful' do
      let!(:denomination1) { create(:denomination, currency: currency, amount: 2, value: 20) }
      let!(:denomination2) { create(:denomination, currency: currency, amount: 2, value: 50) }
      let!(:denomination3) { create(:denomination, currency: currency, amount: 1, value: 100) }

      it 'returns 201' do
        action
        expect(response).to have_http_status(201)
      end

      it 'creates order denominations' do
        action

        body = JSON.parse(response.body)
        order_id = body["id"]
        order = Order.find(order_id)
        expect(order.order_denominations.count).to eq 2

        order_denomination = order.order_denominations.first
        expect(order_denomination.denomination_id).to eq denomination2.id
        expect(order_denomination.amount).to eq 1

        order_denomination = order.order_denominations.last
        expect(order_denomination.denomination_id).to eq denomination1.id
        expect(order_denomination.amount).to eq 2
      end

      it 'updates the stock' do
        action
        expect(denomination1.reload.amount).to eq(0)
        expect(denomination2.reload.amount).to eq(1)
        expect(denomination3.reload.amount).to eq(1)
      end
    end

    context 'unsuccesful' do
      context 'quote does not exist' do
        let(:quote_id) { 999 }

        it 'returns 404' do
          action
          expect(response).to have_http_status(404)
        end
      end

      context 'no denominations to fulfill the order' do
        it 'returns 422 with an error' do
          action
          expect(response).to have_http_status(422)
          expect(JSON.parse(response.body)['error']).to eq("Could Not fulfill Order")
        end
      end
    end
  end
end
