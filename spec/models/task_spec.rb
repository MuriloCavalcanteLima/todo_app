# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Task, type: :model do
    describe 'associations' do
        it { is_expected.to belong_to(:user) }
        it { is_expected.to have_many(:groups).through(:task_groups)}
    end

    describe 'validations' do
        subject{ described_class.new(title: 'Tarefa um', user:)}
        let(:user) { User.new(name:'jose', email: 'jose@email.com', password: 'password' )}
    
        it { is_expected.to validate_presence_of(:title) }
        it { is_expected.to validate_presence_of(:user_id) }
        it { is_expected.to validate_uniqueness_of(:title).scoped_to(:user_id) }
    end
end
