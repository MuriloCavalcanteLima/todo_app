class CreateTaskGroup < ActiveRecord::Migration[7.1]
  def change
    create_table :task_groups do |t|
      t.references :task, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end

    add_index :task_groups, [:task_id, :group_id], unique: true
  end
end