require 'rails_helper'

RSpec.describe QuotesController, type: :controller do
  describe '#create' do
    let(:action) { post :create, params: params }
    let(:params) do { quote: { requested_value: requested_value,
                               currency_id: currency_id } }
    end
    let(:requested_value) { 100 }
    let(:currency) { create(:currency) }
    let(:currency_id) { currency.id }

    context 'successful' do
      let!(:denominations) do
        create(:denomination, currency: currency, amount: 2, value: 20)
        create(:denomination, currency: currency, amount: 2, value: 50)
        create(:denomination, currency: currency, amount: 1, value: 100)
      end

      let(:requested_value) { 99 }

      it 'returns 201' do
        action
        expect(response).to have_http_status(201)
      end

      it 'returns best offered value' do
        action
        quote = JSON.parse(response.body)
        expect(quote['offered_value'].to_i).to eq 90
      end
    end

    context 'unsuccesful' do
      context 'currency does not exist' do
        let(:currency_id) { 999 }

        it 'returns 404' do
          action
          expect(response).to have_http_status(404)
        end
      end

      context 'quote cannot be created' do
        before do
          allow(Quotes::BestApproximation).to receive(:call)
            .and_return(Either.right( { value: 0 } ))
        end
        it 'returns 422' do
          action
          expect(response).to have_http_status(422)
        end
      end

      context 'best offered value is zero' do
        it 'returns 422' do
          action
          expect(response).to have_http_status(422)
        end
      end
    end
  end
end
