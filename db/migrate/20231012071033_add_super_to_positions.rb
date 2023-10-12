class AddSuperToPositions < ActiveRecord::Migration[7.0]
  def change
    add_column :positions, :super, :boolean
  end
end
