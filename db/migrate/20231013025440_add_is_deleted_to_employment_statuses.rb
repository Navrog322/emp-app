class AddIsDeletedToEmploymentStatuses < ActiveRecord::Migration[7.0]
  def change
    add_column :employment_statuses, :is_deleted, :boolean
  end
end
