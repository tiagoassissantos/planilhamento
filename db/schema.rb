# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_22_153224) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "construction_stages", force: :cascade do |t|
    t.string "name"
    t.string "quantity"
    t.string "pavement"
    t.bigint "construction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "sheet"
    t.index ["construction_id"], name: "index_construction_stages_on_construction_id"
  end

  create_table "constructions", force: :cascade do |t|
    t.string "name"
    t.string "contact"
    t.string "contact_number"
    t.string "cpf_cnpj"
    t.string "email"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_constructions_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "salesman"
    t.string "phone"
    t.string "cpf_cnpj"
    t.string "contact"
  end

  create_table "formats", force: :cascade do |t|
    t.string "name"
    t.integer "sides"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_elements", force: :cascade do |t|
    t.integer "position"
    t.string "gauge"
    t.integer "quantity"
    t.jsonb "format_values"
    t.decimal "weight"
    t.bigint "stage_item_id"
    t.bigint "format_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["format_id"], name: "index_item_elements_on_format_id"
    t.index ["stage_item_id"], name: "index_item_elements_on_stage_item_id"
  end

  create_table "logs", force: :cascade do |t|
    t.bigint "user_id"
    t.string "action"
    t.string "registry"
    t.jsonb "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "stage_items", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.bigint "construction_stage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 0
    t.decimal "weight", default: "0.0"
    t.index ["construction_stage_id"], name: "index_stage_items_on_construction_stage_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role", default: 2, null: false
    t.string "name", null: false
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "logs", "users"
end
