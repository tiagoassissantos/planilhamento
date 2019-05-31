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

ActiveRecord::Schema.define(version: 2019_05_31_150507) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "hd_sizes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hd_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keyboard_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lot_items", force: :cascade do |t|
    t.bigint "hardware_type_id"
    t.bigint "model_id"
    t.string "ram_memory"
    t.string "serial_number"
    t.string "asset_tag"
    t.bigint "category_id"
    t.string "comments"
    t.bigint "damage_type_id"
    t.bigint "processor_id"
    t.bigint "disk_type_id"
    t.bigint "disk_size_id"
    t.string "parent_id"
    t.string "screen"
    t.string "webcam"
    t.bigint "keyboard_type_id"
    t.string "wirelles"
    t.string "bluethooth"
    t.string "mini_display_port"
    t.string "hdmi"
    t.string "vga"
    t.string "esata"
    t.string "bright_keyboard"
    t.bigint "destination_id"
    t.string "bar_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_lot_items_on_category_id"
    t.index ["damage_type_id"], name: "index_lot_items_on_damage_type_id"
    t.index ["destination_id"], name: "index_lot_items_on_destination_id"
    t.index ["disk_size_id"], name: "index_lot_items_on_disk_size_id"
    t.index ["disk_type_id"], name: "index_lot_items_on_disk_type_id"
    t.index ["hardware_type_id"], name: "index_lot_items_on_hardware_type_id"
    t.index ["keyboard_type_id"], name: "index_lot_items_on_keyboard_type_id"
    t.index ["model_id"], name: "index_lot_items_on_model_id"
    t.index ["processor_id"], name: "index_lot_items_on_processor_id"
  end

  create_table "lots", force: :cascade do |t|
    t.string "order_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "damage_types", "hardware_types"
  add_foreign_key "lot_items", "categories"
  add_foreign_key "lot_items", "damage_types"
  add_foreign_key "lot_items", "destinations"
  add_foreign_key "lot_items", "disk_sizes"
  add_foreign_key "lot_items", "disk_types"
  add_foreign_key "lot_items", "hardware_types"
  add_foreign_key "lot_items", "keyboard_types"
  add_foreign_key "lot_items", "models"
  add_foreign_key "lot_items", "processors"
  add_foreign_key "models", "manufacturers"
end
