FactoryBot.define do
    factory :user do
        sequence(:email) { |n| "user#{n}@example.com" }
        name { "John Doe" }
        password { "mySecurePassword346" }
        nickname { "John" }
        uid { email }
        tokens { nil }
    end
end