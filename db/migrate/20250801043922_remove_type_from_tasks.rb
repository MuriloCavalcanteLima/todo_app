class RemoveTypeFromTasks < ActiveRecord::Migration[7.1]
  def change
    remove_column :tasks, :type, :string
  end
end
