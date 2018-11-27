FactoryBot.define do
  factory :order do
    quote { create(:quote) }
  end
end
