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

ActiveRecord::Schema.define(version: 2020_05_02_214010) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adoption_email_addresses", force: :cascade do |t|
    t.integer "company_id"
    t.string "email_address"
    t.integer "source_id"
    t.integer "is_invalid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "adoption_phone_numbers", force: :cascade do |t|
    t.integer "company_id"
    t.string "phone_number"
    t.integer "source_id"
    t.integer "is_invalid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.bigint "corporate_num"
    t.date "established_date"
    t.integer "source_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "company_addresses", force: :cascade do |t|
    t.integer "company_id"
    t.string "address"
    t.integer "prefecture_id"
    t.integer "city_id"
    t.integer "source_id"
    t.integer "is_invalid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "company_capitals", force: :cascade do |t|
    t.integer "company_id"
    t.bigint "capital"
    t.integer "is_invalid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "company_contact_forms", force: :cascade do |t|
    t.integer "company_id"
    t.string "contact_form_url"
    t.integer "source_id"
    t.integer "is_invalid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "company_email_addresses", force: :cascade do |t|
    t.integer "company_id"
    t.string "email_address"
    t.integer "source_id"
    t.integer "is_invalid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "company_facebooks", force: :cascade do |t|
    t.integer "company_id"
    t.string "url"
    t.integer "is_invalid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "source_id"
  end

  create_table "company_fax_numbers", force: :cascade do |t|
    t.integer "company_id"
    t.integer "fax_number"
    t.integer "source_id"
    t.integer "is_invalid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "company_industries", force: :cascade do |t|
    t.integer "company_id"
    t.integer "industry_id"
    t.integer "source_id"
    t.integer "is_invalid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "company_listings", force: :cascade do |t|
    t.integer "company_id"
    t.integer "listed"
    t.integer "is_invalid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "company_media_ads", force: :cascade do |t|
    t.integer "company_id"
    t.integer "media_id"
    t.integer "source_id"
    t.integer "is_invalid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "company_phone_numbers", force: :cascade do |t|
    t.integer "company_id"
    t.string "phone_number"
    t.integer "source_id"
    t.integer "is_invalid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "company_presidents", force: :cascade do |t|
    t.integer "company_id"
    t.string "president_name"
    t.integer "source_id"
    t.integer "is_invalid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "company_sectors", force: :cascade do |t|
    t.integer "company_id"
    t.integer "sector_id"
    t.integer "source_id"
    t.integer "is_invalid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "company_twitters", force: :cascade do |t|
    t.integer "company_id"
    t.string "url"
    t.integer "is_invalid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "source_id"
  end

  create_table "company_web_urls", force: :cascade do |t|
    t.string "url"
    t.integer "source_id"
    t.integer "is_invalid"
    t.integer "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "industries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "media", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "mynavi_tenshokus", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "president_name"
    t.string "capital"
    t.string "employees"
    t.string "established_date"
    t.string "web_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "president_email_addresses", force: :cascade do |t|
    t.integer "company_president_id"
    t.string "email_address"
    t.integer "source_id"
    t.integer "is_invalid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "president_phone_numbers", force: :cascade do |t|
    t.integer "company_president_id"
    t.string "phone_number"
    t.integer "source_id"
    t.integer "is_invalid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sectors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "customer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "yahoo_api_manages", force: :cascade do |t|
    t.integer "next_start_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "yahoo_sources", force: :cascade do |t|
    t.bigint "corporate_num"
    t.string "name"
    t.integer "postal_code"
    t.string "address"
    t.string "prefecture_name"
    t.string "city_name"
    t.string "president_name"
    t.bigint "capital"
    t.integer "employees"
    t.date "established_date"
    t.integer "listed"
    t.string "facebook_url"
    t.string "twitter_url"
    t.integer "president_phone_number"
    t.string "web_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phone_number"
    t.integer "industry_code"
    t.integer "is_reflected"
  end

end
