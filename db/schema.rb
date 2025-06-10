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

ActiveRecord::Schema[8.0].define(version: 2025_06_10_144549) do
  create_table "watches", force: :cascade do |t|
    t.string "brand"
    t.string "model"
    t.integer "year"
    t.decimal "case_diameter"
    t.decimal "case_thickness"
    t.decimal "lug_width"
    t.string "reference_number"
    t.string "caliber"
    t.string "movement_type"
    t.text "features"
    t.text "complications"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand"], name: "index_watches_on_brand"
    t.index ["caliber"], name: "index_watches_on_caliber"
    t.index ["model"], name: "index_watches_on_model"
    t.index ["reference_number"], name: "index_watches_on_reference_number"
    t.index ["year"], name: "index_watches_on_year"
  end
end
