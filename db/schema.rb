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

ActiveRecord::Schema.define(version: 2024_04_22_132952) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "application_forms", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.bigint "part_id"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_application_forms_on_group_id"
    t.index ["user_id"], name: "index_application_forms_on_user_id"
  end

  create_table "banners", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "type"
    t.string "youtube_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.text "body"
    t.text "answer"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.bigint "musical_id", null: false
    t.string "title"
    t.integer "status"
    t.datetime "audition_date"
    t.datetime "submit_end_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "performance_date"
    t.datetime "submit_start_at"
    t.string "application_link"
    t.string "concert_hall"
    t.string "musical_alias"
    t.index ["musical_id"], name: "index_groups_on_musical_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "imagable_type"
    t.bigint "imagable_id"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["imagable_type", "imagable_id"], name: "index_images_on_imagable_type_and_imagable_id"
  end

  create_table "musicals", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "_type"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notices", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "position"
    t.integer "status"
    t.integer "_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "parts", force: :cascade do |t|
    t.bigint "musical_id", null: false
    t.bigint "rating_id", null: false
    t.string "title"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["musical_id"], name: "index_parts_on_musical_id"
    t.index ["rating_id"], name: "index_parts_on_rating_id"
  end

  create_table "phone_certifications", force: :cascade do |t|
    t.string "phone"
    t.string "code"
    t.datetime "confirmed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.string "title"
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "status"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_groups", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_user_groups_on_group_id"
    t.index ["user_id"], name: "index_user_groups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name", default: ""
    t.string "phone"
    t.string "image"
    t.integer "gender", limit: 2, default: 0
    t.integer "status", limit: 2, default: 0
    t.integer "user_type", limit: 2, default: 0
    t.text "description"
    t.integer "reviews_count"
    t.string "uid"
    t.string "provider"
    t.string "device_token"
    t.string "device_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "role_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "application_forms", "groups"
  add_foreign_key "application_forms", "users"
  add_foreign_key "contacts", "users"
  add_foreign_key "groups", "musicals"
  add_foreign_key "parts", "musicals"
  add_foreign_key "parts", "ratings"
  add_foreign_key "reservations", "users"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "users"
  add_foreign_key "users", "roles"
end
