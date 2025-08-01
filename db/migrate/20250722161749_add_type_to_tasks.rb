class AddTypeToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :type, :string, null: false, default: 'Task'
  end
end
