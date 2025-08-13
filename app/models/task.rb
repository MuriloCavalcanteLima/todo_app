class Task < ApplicationRecord
  belongs_to :user

  has_many :task_groups, dependent: :destroy
  has_many :groups, through: :task_groups

  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :user_id, presence: true
end
