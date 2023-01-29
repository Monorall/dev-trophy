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

ActiveRecord::Schema[7.0].define(version: 2023_01_23_200936) do
  create_table "documents", force: :cascade do |t|
    t.string "title"
    t.integer "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_documents_on_project_id"
  end

  create_table "ecosystems", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issues", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "document_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "thumbnail"
    t.index ["document_id"], name: "index_issues_on_document_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.integer "ecosystem_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ecosystem_id"], name: "index_projects_on_ecosystem_id"
  end

  create_table "scores", force: :cascade do |t|
    t.string "participant", null: false
    t.string "trophies"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "documents", "projects"
  add_foreign_key "issues", "documents"
  add_foreign_key "projects", "ecosystems"
end
