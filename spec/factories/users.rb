FactoryGirl.define do
  factory :user do
    account
    sequence(:login) { |i| "user_#{i}" }
    email       { |u| "#{u.login}@email.com" }
    password    "qwerty123456"
    password_confirmation "qwerty123456"
    first_name  { |u| u.login }
    last_name   "Tester"
    role        "role"

    trait :admin do
      admin true
      ssh_public_key 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEA1uVTQU9G4IV0x0SnEpuNbME/XMArXcNYXTPJReLlcFYEOFr3WVV5eP6kbXRgTbtlMvVCnxJ/vGRk6K1pIIw45QOBWbPjXPV7K538nRJaWgegEwVfRNvEN1gZJltEDQC9RJyg4kv76gTBzc/dPndQ8M18ZBQqDQIGQT+d2cw9B9M= recess@flex.websitewelcome.com'
    end

    trait :suspended do
      suspended true
    end
  end
end
