#frozen_string_literal: true

class groupsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_group, only: [:show, :update, :destroy]
    
    def index
        @groups = current_user.groups
        render json: @groups, status: :ok
    end
    
    def show
        render json: @group, status: :ok
    end
    
    def create
        @group = current_user.groups.new(group_params)
        if @group.save
        render json: @group, status: :created
        else
        render json: { errors: @group.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    def update
        if @group.update(group_params)
        render json: @group, status: :ok
        else
        render json: { errors: @group.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    def destroy
        @group.destroy
        head :no_content
    end
    
    private
    
    def set_group
        @group = current_user.groups.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { error: 'Group not found' }, status: :not_found
    end
    
    def group_params
        params.require(:group).permit(:name, :description)
    end
end