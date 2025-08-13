FactoryBot.define do
    factory :task do
        title { 'Comer, saudavelmente' }
        description { '150arroz branco, 150g feijao...' }
        status { 'pending' }
        due_date { Date.tomorrow }
        user { create(:user) }
    end
end