class AddIsDeletedToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :is_deleted, :boolean
  end
end
