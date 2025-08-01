class AddGroups < ActiveRecord::Migration[7.1]
  def change

    create_table(:groups) do |t|
      t.string :name, :null => false
      t.text :description
      t.references :user, :null => false, :foreign_key => true
    end

  end
end
