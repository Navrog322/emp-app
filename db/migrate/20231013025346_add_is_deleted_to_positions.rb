class AddIsDeletedToPositions < ActiveRecord::Migration[7.0]
  def change
    add_column :positions, :is_deleted, :boolean
  end
end
