# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::GroupsController, type: :request do

    let(:auth_headers) do
        post '/auth/sign_in', params: params
        {
        'client' => response.headers['client'],
        'uid' => response.headers['uid'],
        'access-token' => response.headers['access-token']
        }
    end

    context 'when authentication fails' do
        let(:params) { { email: 'strangeman@email.com', password: 'unauthorized' } }

        it 'responds with unauthorized' do
            get api_groups_path, headers: auth_headers

            expect(response).to have_http_status(:unauthorized)
        end
    end

    context 'when authentication succeeds' do
        let(:user) { create(:user) }
        let(:params) { { email: user.email, password: user.password } }

        describe 'GET #index' do
            it 'responds with authorized' do
                get api_groups_path, headers: auth_headers

                expect(response).to have_http_status(:ok)
                
            end
        end

        describe 'GET #show' do
            let(:group) { create(:group, user:) }

            it 'responds with authorized', :aggregate_failures do
                get api_group_path(group), headers: auth_headers

                json = JSON.parse(response.body)

                expect(response).to have_http_status(:ok)
                expect(json).to be_a(Hash)
                expect(json['id']).to eq(group.id)
                expect(json['name']).to eq(group.name)
            end
        end

        describe 'POST #create' do
            let(:group_params) { { 'group': { name: 'new_group', description: 'some description' } } }

            it 'responds with authorized', :aggregate_failures do
                post api_groups_path, params: group_params, headers: auth_headers

                json = JSON.parse(response.body)

                expect(response).to have_http_status(:created)
                expect(json).to be_a(Hash)
                expect(json['name']).to eq('new_group')
                expect(json['description']).to eq('some description')
            end
        end

        describe 'PUT #update', :aggregate_failures do
            let(:group) { create(:group, user:) }
            let(:group_params) { { 'group': { name: 'edited_name_group' } } }

            it 'updates succesfully', :aggregate_failures do
                put api_group_path(group), headers: auth_headers, params: group_params

                expect(response).to have_http_status(:ok)
                expect(group.reload.name).to eq('edited_name_group')

                json = JSON.parse(response.body)

                expect(json).to be_a(Hash)
                expect(json['name']).to eq('edited_name_group')
            end
        end

        describe 'DELETE #destroy', :aggregate_failures do
            let(:group) { create(:group, user:) }

            it 'deletes group' do
                delete api_group_path(group), headers: auth_headers

                expect(response).to have_http_status(:ok)
                expect { Group.find(group.id) }.to raise_error(ActiveRecord::RecordNotFound)
            end
        end
    end
end
