FactoryBot.define do
  factory :currency do
    code { 'EUR' }
    exchange_rate { 1.5 }
  end
end
