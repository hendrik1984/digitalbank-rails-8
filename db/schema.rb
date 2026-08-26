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

ActiveRecord::Schema[8.1].define(version: 2026_08_26_083645) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "account_number", null: false
    t.decimal "balance", precision: 20, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.string "currency", default: "IDR", null: false
    t.string "status", default: "active", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["account_number"], name: "index_accounts_on_account_number", unique: true
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "deposits", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.decimal "amount", precision: 20, scale: 2, null: false
    t.datetime "created_at", null: false
    t.string "reference", null: false
    t.string "status", default: "pending", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_deposits_on_account_id"
    t.index ["reference"], name: "index_deposits_on_reference", unique: true
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount", precision: 20, scale: 2, null: false
    t.datetime "created_at", null: false
    t.bigint "deposit_id", null: false
    t.string "reference", null: false
    t.string "status", default: "pending", null: false
    t.datetime "updated_at", null: false
    t.index ["deposit_id"], name: "index_payments_on_deposit_id"
    t.index ["reference"], name: "index_payments_on_reference", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.decimal "amount", precision: 20, scale: 2, null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "direction", null: false
    t.string "reference", null: false
    t.string "transaction_type", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["reference"], name: "index_transactions_on_reference", unique: true
  end

  create_table "transfers", force: :cascade do |t|
    t.decimal "amount", precision: 20, scale: 2, null: false
    t.datetime "created_at", null: false
    t.bigint "destination_account_id", null: false
    t.string "reference", null: false
    t.bigint "source_account_id", null: false
    t.string "status", default: "pending", null: false
    t.datetime "updated_at", null: false
    t.index ["destination_account_id"], name: "index_transfers_on_destination_account_id"
    t.index ["reference"], name: "index_transfers_on_reference", unique: true
    t.index ["source_account_id"], name: "index_transfers_on_source_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "status", default: "active"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "withdrawals", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.decimal "amount", precision: 20, scale: 2, null: false
    t.datetime "created_at", null: false
    t.string "reference", null: false
    t.string "status", default: "pending", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_withdrawals_on_account_id"
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "deposits", "accounts"
  add_foreign_key "payments", "deposits"
  add_foreign_key "transactions", "accounts"
  add_foreign_key "transfers", "accounts", column: "destination_account_id"
  add_foreign_key "transfers", "accounts", column: "source_account_id"
  add_foreign_key "withdrawals", "accounts"
end
