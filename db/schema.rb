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

ActiveRecord::Schema[7.0].define(version: 2023_05_01_162210) do
  create_table "borrowers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fees", force: :cascade do |t|
    t.decimal "percentage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.string "invoice_number", null: false
    t.decimal "amount"
    t.datetime "due_date"
    t.integer "status"
    t.text "scan"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "borrower_id"
    t.integer "fee_id"
    t.decimal "total_accrued"
    t.index ["borrower_id"], name: "index_invoices_on_borrower_id"
    t.index ["fee_id"], name: "index_invoices_on_fee_id"
    t.index ["invoice_number"], name: "index_invoices_on_invoice_number", unique: true
  end

  add_foreign_key "invoices", "borrowers"
  add_foreign_key "invoices", "fees"
end
