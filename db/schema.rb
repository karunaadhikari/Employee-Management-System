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

ActiveRecord::Schema.define(version: 2022_03_02_073539) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "country"
    t.string "state"
    t.string "district"
    t.string "city"
    t.string "street"
    t.string "house_no"
    t.bigint "employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "kind"
    t.index ["employee_id"], name: "index_addresses_on_employee_id"
    t.index ["kind"], name: "index_addresses_on_kind", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "emp_leave_infos", force: :cascade do |t|
    t.text "reason"
    t.bigint "leave_info_id", null: false
    t.bigint "employee_id", null: false
    t.date "date_from"
    t.date "date_to"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_emp_leave_infos_on_employee_id"
    t.index ["leave_info_id"], name: "index_emp_leave_infos_on_leave_info_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "uid"
    t.string "fname"
    t.string "lname"
    t.integer "position"
    t.integer "gender"
    t.date "join_date"
    t.integer "status"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_employees_on_uid", unique: true
  end

  create_table "kycs", force: :cascade do |t|
    t.string "phone"
    t.date "dob"
    t.integer "marital_status"
    t.string "spouse_name"
    t.string "spouse_phone"
    t.string "spouse_email"
    t.bigint "employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.index ["employee_id"], name: "index_kycs_on_employee_id"
  end

  create_table "leave_infos", force: :cascade do |t|
    t.string "uid"
    t.integer "kind"
    t.integer "default_days"
    t.text "description"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wfhs", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.datetime "availability_from", precision: 6
    t.time "availability_to"
    t.text "reason"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_wfhs_on_employee_id"
  end

  add_foreign_key "addresses", "employees"
  add_foreign_key "emp_leave_infos", "employees"
  add_foreign_key "emp_leave_infos", "leave_infos"
  add_foreign_key "kycs", "employees"
  add_foreign_key "wfhs", "employees"
end
