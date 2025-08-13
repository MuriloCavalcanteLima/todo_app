# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Group, type: :model do
    describe 'associations' do
        it { is_expected.to belong_to(:user) }
        it { is_expected.to have_many(:tasks).through(:task_groups) }
    end

    describe 'validations' do
        subject { described_class.new(name: 'Grupo', user: user) }

        let!(:user) { User.new( name: 'jose', email: 'jose@email.com', password: 'PASSWORD')}

        it { is_expected.to validate_presence_of(:name) }
        it { is_expected.to validate_presence_of(:user_id) }
        it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id)}
    end
end