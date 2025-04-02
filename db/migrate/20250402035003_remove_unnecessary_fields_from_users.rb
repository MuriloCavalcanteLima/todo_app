class RemoveUnnecessaryFieldsFromUsers < ActiveRecord::Migration[7.1]
  def change
    def change
      remove_column :users, :name, :string
      remove_column :users, :nickname, :string
      remove_column :users, :image, :string
      remove_column :users, :allow_password_change, :boolean
      remove_column :users, :confirmation_token, :string
      remove_column :users, :confirmed_at, :datetime
      remove_column :users, :confirmation_sent_at, :datetime
      remove_column :users, :unconfirmed_email, :string
    end
  end
end
