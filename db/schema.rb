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

ActiveRecord::Schema[7.0].define(version: 2023_10_14_012619) do
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
    t.boolean "is_deleted"
    t.index ["employment_status_id"], name: "index_employees_on_employment_status_id"
    t.index ["position_id"], name: "index_employees_on_position_id"
    t.index ["superior_id"], name: "index_employees_on_superior_id"
  end

  create_table "employment_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_deleted"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "positions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "super"
    t.boolean "is_deleted"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.integer "language_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "supervisor_id", null: false
    t.boolean "is_deleted"
    t.index ["language_id"], name: "index_projects_on_language_id"
    t.index ["supervisor_id"], name: "index_projects_on_supervisor_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.boolean "is_completed"
    t.integer "project_id", null: false
    t.integer "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_deleted"
    t.index ["employee_id"], name: "index_tasks_on_employee_id"
    t.index ["project_id"], name: "index_tasks_on_project_id"
  end

  add_foreign_key "employees", "employment_statuses"
  add_foreign_key "employees", "positions"
  add_foreign_key "projects", "languages"
  add_foreign_key "tasks", "employees"
  add_foreign_key "tasks", "projects"
end
