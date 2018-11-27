FactoryBot.define do
  factory :quote do
    currency { create(:currency) }
  end
end
