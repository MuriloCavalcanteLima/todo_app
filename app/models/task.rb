class Task < ApplicationRecord
  belongs_to :user

  has_many :taskgroups, dependent: :destroy
  has_many :groups, through: :taskgroups

  
end
