class AddIsDeletedToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :is_deleted, :boolean
  end
end
