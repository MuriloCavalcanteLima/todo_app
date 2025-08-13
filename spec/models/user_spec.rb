# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do 
    describe 'associations' do
        it { is_expected.to have_many(:tasks) }
        it { is_expected.to have_many(:groups) }
    end

    describe 'validations' do
        subject{ described_class.new(name: 'name', email: 'name@email.com', password: 'password')}
        it { is_expected.to validate_presence_of(:email)}
        it { is_expected.to validate_presence_of(:name)}
    end

end