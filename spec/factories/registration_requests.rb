FactoryGirl.define do
  factory :registration_request do
    organization_name "org"
    state             "CA"
    website           "http://org.com"
    admin_first_name  "Mark"
    admin_last_name   "Smith"
    admin_title       "Mr"
    admin_email       "mark@org.com"
    admin_phone       "1231231231"

    trait :rejected do
      rejected true
    end
  end
end
