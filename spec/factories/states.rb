FactoryGirl.define do
  factory :state do
    sequence(:code) { |i| "s#{i}" }
    sequence(:name) { |i| "State #{i}" }
  end
end
