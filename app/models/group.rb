#frozen_string_literal: true

class Group < ApplicationRecord
    belongs_to :user

    has_many :task_groups, dependent: :destroy
    has_many :tasks, through: :task_groups

    validates :name, presence: true, uniqueness: { scope: :user_id }
    validates :user_id, presence: true
end