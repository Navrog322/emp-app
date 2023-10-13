class AddSupervisorToProjects < ActiveRecord::Migration[7.0]
  def change
    add_reference :projects, :supervisor, null: false, index: true
  end
end
