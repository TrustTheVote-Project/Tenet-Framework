FactoryGirl.define do
  factory :account do
    state
    sequence(:name) { |i| "Account #{i}" }
  end
end
