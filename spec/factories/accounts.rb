FactoryGirl.define do
  factory :account do
    state
    sequence(:name) { |i| "Account #{i}" }

    trait :suspended do
      suspended true
    end
  end
end
