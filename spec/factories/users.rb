FactoryBot.define do
    factory :user do
        name { "John Doe" }
        email { "john@mail.com" }
        password { "mySecurePassword346" }
        nickname { "John" }
    end
end