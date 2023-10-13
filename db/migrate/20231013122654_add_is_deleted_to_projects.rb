class AddIsDeletedToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :is_deleted, :boolean
  end
end
