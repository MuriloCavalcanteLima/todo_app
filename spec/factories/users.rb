FactoryBot.define do
    factory :user do
        name { "John Doe" }
        email { "john@mail.com" }
        password { "mySecurePassword346" }
        nickname { "John" }
        uid { email }
        tokens { nil }
    end
end