class User < ApplicationRecord
  # Include Devise modules for both Devise and Devise Token Auth
  extend Devise::Models # <-- Adicione isso se necessário
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :tasks, dependent: :destroy
end