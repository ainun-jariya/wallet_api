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

ActiveRecord::Schema[7.0].define(version: 2023_07_16_191237) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "money", force: :cascade do |t|
    t.bigint "wallet_id"
    t.float "debit"
    t.float "credit"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["wallet_id"], name: "index_money_on_wallet_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "token"
    t.bigint "user_id"
    t.string "device"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.datetime "logged_in_at"
    t.datetime "logged_out_at"
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "indices"
    t.string "identifier"
    t.string "symb"
    t.integer "number_of_item"
    t.string "typeable_type", default: "User"
    t.bigint "typeable_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["typeable_type", "typeable_id"], name: "index_stocks_on_typeable"
  end

  create_table "team_members", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["team_id"], name: "index_team_members_on_team_id"
    t.index ["user_id"], name: "index_team_members_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "product_type", default: "Stock"
    t.bigint "product_id"
    t.bigint "wallet_id"
    t.float "debit"
    t.float "credit"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["product_type", "product_id"], name: "index_transactions_on_product"
    t.index ["wallet_id"], name: "index_transactions_on_wallet_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone", limit: 15
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "password"
  end

  create_table "wallets", force: :cascade do |t|
    t.string "typeable_type", default: "User"
    t.bigint "typeable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["typeable_type", "typeable_id"], name: "index_wallets_on_typeable"
  end

end
