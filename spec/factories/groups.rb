FactoryBot.define do
    factory :group do
        sequence(:name) { |n| "Tarefas de #{n}" }
        description { "Tarefas relacionadas a #{name}"}
        user {  create(:user) }
    end
end