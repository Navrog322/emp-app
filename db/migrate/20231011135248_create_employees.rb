class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :JMBG
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :address
      t.references :position, null: false, foreign_key: true
      t.date :employment_date
      t.references :superior, null: true, index: true
      t.references :employment_status, null: false, foreign_key: true

      t.timestamps
    end
  end
end
