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

ActiveRecord::Schema.define(version: 2019_12_09_221908) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "meals", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.bigint "recipe_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_meals_on_recipe_id"
    t.index ["user_id"], name: "index_meals_on_user_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.text "directions"
    t.float "servings"
    t.float "energy"
    t.float "carbs"
    t.float "fiber"
    t.float "sugar"
    t.float "fat"
    t.float "monounsaturated"
    t.float "polyunsaturated"
    t.float "omega3"
    t.float "omega6"
    t.float "saturated"
    t.float "transfat"
    t.float "cholesterol"
    t.float "protein"
    t.float "vit_b1"
    t.float "vit_b2"
    t.float "vit_b3"
    t.float "vit_b5"
    t.float "vit_b6"
    t.float "vit_b12"
    t.float "biotin"
    t.float "choline"
    t.float "folate"
    t.float "vit_a"
    t.float "vit_c"
    t.float "vit_d"
    t.float "vit_e"
    t.float "vit_k"
    t.float "calcium"
    t.float "chromium"
    t.float "copper"
    t.float "fluoride"
    t.float "iodine"
    t.float "iron"
    t.float "magnesium"
    t.float "manganese"
    t.float "molybdenum"
    t.float "phosphorus"
    t.float "potassium"
    t.float "selenium"
    t.float "sodium"
    t.float "zinc"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "meals", "recipes"
  add_foreign_key "meals", "users"
  add_foreign_key "recipes", "users"
end
