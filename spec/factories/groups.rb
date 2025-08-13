FactoryBot.define do
    factory :group do
        name { 'Tarefas de saúde' }
        description { "Tarefas relacionadas a condicionamento fisico e nutrição "}
        user {  create(:user) }
    end
end