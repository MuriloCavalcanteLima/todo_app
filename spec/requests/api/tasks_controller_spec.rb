# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::TasksController, type: :request do

  describe 'when authentication fails' do
    let(:user) { create(:user) }
    let(:params) { { email: user.email, password: 'wrongpassword' } }

    let(:auth_headers) do
        post '/auth/sign_in', params: params
        {
        'client' => response.headers['client'],
        'uid' => response.headers['uid'],
        'access-token' => response.headers['access-token']
        }
    end

    it 'responds with unauthorized' do
      get api_tasks_path, headers: auth_headers

      response_body = JSON.parse(response.body)

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'when authentication succeeds' do
    let(:user) { create(:user) }
    let(:params) { { email: user.email, password: user.password } }

    let(:auth_headers) do
        post '/auth/sign_in', params: params
        {
        'client' => response.headers['client'],
        'uid' => response.headers['uid'],
        'access-token' => response.headers['access-token']
        }
    end

    it 'responds with unauthorized' do
      get api_tasks_path, headers: auth_headers

      expect(response).to have_http_status(:ok)
    end

    describe 'GET #index' do
      before { create_list(:task, 2, user:) }

      it 'respond with the current user tasks', :aggregate_failures do
          get api_tasks_path, headers: auth_headers
          
          json = JSON.parse(response.body)

          expect(response).to have_http_status(:ok)
          expect(json).to be_an(Array)
          expect(json.size).to eq(user.tasks.count)
      end
    end

    describe 'GET #show' do
      let(:task) { create(:task, user:) }

      it 'responds with required task', :aggregate_failures do
          get api_task_path(task), headers: auth_headers

          json = JSON.parse(response.body)

          expect(response).to have_http_status(:ok)
          expect(json).to be_a(Hash)
          expect(json['id']).to eq(task.id)
      end
    end

    describe 'POST #create' do
      let(:task_params) { { 'task': { title: 'new_task', description: 'some description' } } }

      it 'creates and responds with the created object', :aggregate_failures do
        post api_tasks_path, params: task_params, headers: auth_headers

        json = JSON.parse(response.body)

        expect(response).to have_http_status(:created)
        expect(json).to be_a(Hash)
        expect(json['id']).to eq(user.tasks.last.id)
      end
    end

    describe 'PUT #update', :aggregate_failures do
      let(:task) { create(:task, user:) }
      let(:task_params) { { 'task': { title: 'edited_name_task' } } }

      it 'updates and responds with the updated object', :aggregate_failures do
          put api_task_path(task), headers: auth_headers, params: task_params

          expect(response).to have_http_status(:ok)
          expect(task.reload.title).to eq('edited_name_task')

          json = JSON.parse(response.body)

          expect(json).to be_a(Hash)
          expect(json['title']).to eq('edited_name_task')
      end
    end

    describe 'DELETE #destroy', :aggregate_failures do
        let(:task) { create(:task, user:) }

        it 'deletes task' do
            delete api_task_path(task), headers: auth_headers

            expect(response).to have_http_status(:ok)
            expect { Task.find(task.id) }.to raise_error(ActiveRecord::RecordNotFound)
        end
    end
  end
end