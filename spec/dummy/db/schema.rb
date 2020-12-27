# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_29_193419) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rakeman_rake_tasks", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.boolean "done", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rakeman_task_parameters", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "rakeman_rake_task_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "parameter_position", default: 0
    t.index ["rakeman_rake_task_id"], name: "index_rakeman_task_parameters_on_rakeman_rake_task_id"
  end

end
