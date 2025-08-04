class AddGroupIdToTask < ActiveRecord::Migration[7.1]
  def change
    add_reference :tasks, :group, foreign_key: true, null: true
  end
end
