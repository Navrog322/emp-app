# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_10_12_071033) do
  create_table "employees", force: :cascade do |t|
    t.string "JMBG"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "address"
    t.integer "position_id", null: false
    t.date "employment_date"
    t.integer "superior_id"
    t.integer "employment_status_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employment_status_id"], name: "index_employees_on_employment_status_id"
    t.index ["position_id"], name: "index_employees_on_position_id"
    t.index ["superior_id"], name: "index_employees_on_superior_id"
  end

  create_table "employment_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "positions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "super"
  end

  add_foreign_key "employees", "employment_statuses"
  add_foreign_key "employees", "positions"
end
