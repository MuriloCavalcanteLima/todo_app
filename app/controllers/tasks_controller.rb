#frozen_string_literal: true

class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_task, only: %i[show update destroy]

    def index
        tasks = current_user.tasks.order(created_at: :desc)
        render json: tasks, status: :ok
    end

    def show
        render json: @task, status: :ok
    end

    def create
        @task = current_user.tasks.build(permitted_params)
        
        if @task.save
            if params[:task][:group_id].present?
                group = current_user.groups.find(params[:task][:group_id])

                if group.present?
                    TaskGroup.create(task: @task, group: group)
                else
                    render json: { error: 'Grupo não encontrado ou não pertence ao usuário' }, status: :unprocessable_entity
                    return
                end
            end

            render json: @task, status: :created
        else
            render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        if @task.update(permitted_params)
            render json: @task, status: :ok
        else
            render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        @task.destroy
        head :no_content
    end

    private

    def set_task
        @task = current_user.tasks.find_by(id: params[:id])
        render json: { error: 'Task not found' }, status: :not_found if @task.nil?
    end

    def permitted_params
        params.require(:task).permit(:title, :description, :due_date, :completed, :status, :group_id).merge(user: current_user)
    end
end
