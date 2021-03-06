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

ActiveRecord::Schema.define(version: 20161219034639) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "brands", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "day_parts", force: :cascade do |t|
    t.string   "name"
    t.integer  "location_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["location_id"], name: "index_day_parts_on_location_id", using: :btree
  end

  create_table "local_pricings", force: :cascade do |t|
    t.integer  "location_id",    null: false
    t.integer  "price_level_id", null: false
    t.integer  "order_type_id",  null: false
    t.integer  "day_part_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["day_part_id"], name: "index_local_pricings_on_day_part_id", using: :btree
    t.index ["location_id"], name: "index_local_pricings_on_location_id", using: :btree
    t.index ["order_type_id"], name: "index_local_pricings_on_order_type_id", using: :btree
    t.index ["price_level_id", "order_type_id", "day_part_id"], name: "local_pricing_index", unique: true, using: :btree
    t.index ["price_level_id"], name: "index_local_pricings_on_price_level_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "brand_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_locations_on_brand_id", using: :btree
  end

  create_table "menu_items", force: :cascade do |t|
    t.string   "name"
    t.integer  "brand_id",                                              null: false
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.decimal  "default_price", precision: 5, scale: 2, default: "0.0", null: false
    t.index ["brand_id"], name: "index_menu_items_on_brand_id", using: :btree
  end

  create_table "order_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "brand_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_order_types_on_brand_id", using: :btree
  end

  create_table "price_levels", force: :cascade do |t|
    t.string   "name"
    t.integer  "brand_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_price_levels_on_brand_id", using: :btree
  end

  create_table "prices", force: :cascade do |t|
    t.decimal  "amount",         precision: 5, scale: 2, default: "0.0", null: false
    t.integer  "menu_item_id",                                           null: false
    t.integer  "price_level_id",                                         null: false
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.index ["menu_item_id", "price_level_id"], name: "index_prices_on_menu_item_id_and_price_level_id", unique: true, using: :btree
    t.index ["menu_item_id"], name: "index_prices_on_menu_item_id", using: :btree
    t.index ["price_level_id", "menu_item_id"], name: "index_prices_on_price_level_id_and_menu_item_id", unique: true, using: :btree
    t.index ["price_level_id"], name: "index_prices_on_price_level_id", using: :btree
  end

  add_foreign_key "day_parts", "locations"
  add_foreign_key "local_pricings", "day_parts"
  add_foreign_key "local_pricings", "locations"
  add_foreign_key "local_pricings", "order_types"
  add_foreign_key "local_pricings", "price_levels"
  add_foreign_key "locations", "brands"
  add_foreign_key "menu_items", "brands"
  add_foreign_key "order_types", "brands"
  add_foreign_key "price_levels", "brands"
  add_foreign_key "prices", "menu_items"
  add_foreign_key "prices", "price_levels"
end
