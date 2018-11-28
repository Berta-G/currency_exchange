FactoryBot.define do
  factory :quote do
    currency { create(:currency) }
    requested_value { 100 }
    offered_value { 99 }
  end
end
