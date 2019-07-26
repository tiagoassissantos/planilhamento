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

ActiveRecord::Schema.define(version: 2019_07_26_164227) do

  # These are extensions that must be enabled in order to support this database
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

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "damage_types", force: :cascade do |t|
    t.string "name"
    t.bigint "hardware_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hardware_type_id"], name: "index_damage_types_on_hardware_type_id"
  end

  create_table "destinations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "can_delete", default: true
  end

  create_table "disk_sizes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "disk_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hardware_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "can_delete", default: true
  end

  create_table "keyboard_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lot_item_damage_types", force: :cascade do |t|
    t.bigint "lot_item_id"
    t.bigint "damage_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["damage_type_id"], name: "index_lot_item_damage_types_on_damage_type_id"
    t.index ["lot_item_id"], name: "index_lot_item_damage_types_on_lot_item_id"
  end

  create_table "lot_items", force: :cascade do |t|
    t.bigint "hardware_type_id"
    t.bigint "model_id"
    t.string "ram_memory", null: false
    t.string "serial_number", null: false
    t.string "asset_tag"
    t.bigint "category_id"
    t.string "comments"
    t.bigint "processor_id"
    t.bigint "disk_type_id"
    t.bigint "disk_size_id"
    t.string "parent_id"
    t.string "screen"
    t.string "webcam"
    t.bigint "keyboard_type_id"
    t.string "bluetooth"
    t.string "bright_keyboard"
    t.bigint "destination_id"
    t.string "bar_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "biometric_reader"
    t.string "vga_card"
    t.integer "lot_id"
    t.integer "sku_id"
    t.bigint "sales_order_id"
    t.string "color"
    t.index ["category_id"], name: "index_lot_items_on_category_id"
    t.index ["destination_id"], name: "index_lot_items_on_destination_id"
    t.index ["disk_size_id"], name: "index_lot_items_on_disk_size_id"
    t.index ["disk_type_id"], name: "index_lot_items_on_disk_type_id"
    t.index ["hardware_type_id"], name: "index_lot_items_on_hardware_type_id"
    t.index ["keyboard_type_id"], name: "index_lot_items_on_keyboard_type_id"
    t.index ["model_id"], name: "index_lot_items_on_model_id"
    t.index ["processor_id"], name: "index_lot_items_on_processor_id"
    t.index ["sales_order_id"], name: "index_lot_items_on_sales_order_id"
  end

  create_table "lots", force: :cascade do |t|
    t.string "order_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "models", force: :cascade do |t|
    t.string "name"
    t.bigint "manufacturer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manufacturer_id"], name: "index_models_on_manufacturer_id"
  end

  create_table "processors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales_orders", force: :cascade do |t|
    t.string "order_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sku_damage_types", force: :cascade do |t|
    t.bigint "sku_id"
    t.bigint "damage_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["damage_type_id"], name: "index_sku_damage_types_on_damage_type_id"
    t.index ["sku_id"], name: "index_sku_damage_types_on_sku_id"
  end

  create_table "skus", force: :cascade do |t|
    t.string "code"
    t.string "screen"
    t.string "webcam"
    t.string "bluetooth"
    t.string "bright_keyboard"
    t.string "biometric_reader"
    t.string "vga_card"
    t.bigint "hardware_type_id"
    t.bigint "manufacturer_id"
    t.bigint "model_id"
    t.bigint "category_id"
    t.bigint "damage_type_id"
    t.bigint "processor_id"
    t.bigint "disk_size_id"
    t.bigint "disk_type_id"
    t.bigint "keyboard_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ram_memory"
    t.string "color"
    t.index ["category_id"], name: "index_skus_on_category_id"
    t.index ["damage_type_id"], name: "index_skus_on_damage_type_id"
    t.index ["disk_size_id"], name: "index_skus_on_disk_size_id"
    t.index ["disk_type_id"], name: "index_skus_on_disk_type_id"
    t.index ["hardware_type_id"], name: "index_skus_on_hardware_type_id"
    t.index ["keyboard_type_id"], name: "index_skus_on_keyboard_type_id"
    t.index ["manufacturer_id"], name: "index_skus_on_manufacturer_id"
    t.index ["model_id"], name: "index_skus_on_model_id"
    t.index ["processor_id"], name: "index_skus_on_processor_id"
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
  add_foreign_key "damage_types", "hardware_types"
  add_foreign_key "lot_items", "categories"
  add_foreign_key "lot_items", "destinations"
  add_foreign_key "lot_items", "disk_sizes"
  add_foreign_key "lot_items", "disk_types"
  add_foreign_key "lot_items", "hardware_types"
  add_foreign_key "lot_items", "keyboard_types"
  add_foreign_key "lot_items", "models"
  add_foreign_key "lot_items", "processors"
  add_foreign_key "lot_items", "sales_orders"
  add_foreign_key "models", "manufacturers"
  add_foreign_key "skus", "categories"
  add_foreign_key "skus", "damage_types"
  add_foreign_key "skus", "disk_sizes"
  add_foreign_key "skus", "disk_types"
  add_foreign_key "skus", "hardware_types"
  add_foreign_key "skus", "keyboard_types"
  add_foreign_key "skus", "manufacturers"
  add_foreign_key "skus", "models"
  add_foreign_key "skus", "processors"
end
