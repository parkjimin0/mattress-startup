FactoryBot.define do
  factory :inventory do
    name { "Test Inventory" }
    damaged { false }
    association :warehouse
  end
end
