# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141029034521) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "allergens", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description",     default: "No Description"
    t.boolean  "manual_enter"
    t.boolean  "top_allergen"
    t.boolean  "common_allergen"
  end

  create_table "allergens_ingredients", id: false, force: true do |t|
    t.integer "allergen_id",   null: false
    t.integer "ingredient_id", null: false
  end

  add_index "allergens_ingredients", ["allergen_id"], name: "index_allergens_ingredients_on_allergen_id", using: :btree
  add_index "allergens_ingredients", ["ingredient_id"], name: "index_allergens_ingredients_on_ingredient_id", using: :btree

  create_table "allergens_patient_groups", id: false, force: true do |t|
    t.integer "allergen_id",      null: false
    t.integer "patient_group_id", null: false
  end

  add_index "allergens_patient_groups", ["allergen_id"], name: "index_allergens_patient_groups_on_allergen_id", using: :btree
  add_index "allergens_patient_groups", ["patient_group_id"], name: "index_allergens_patient_groups_on_patient_group_id", using: :btree

  create_table "appointments", force: true do |t|
    t.integer  "patient_focus_id"
    t.integer  "appointment_host_id"
    t.integer  "dietitian_id"
    t.datetime "date"
    t.integer  "room_id"
    t.text     "note"
    t.text     "client_note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: true do |t|
    t.text     "content"
    t.integer  "dietitian_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["dietitian_id"], name: "index_articles_on_dietitian_id", using: :btree

  create_table "articles_characteristics", id: false, force: true do |t|
    t.integer "article_id"
    t.integer "characteristic_id"
  end

  add_index "articles_characteristics", ["article_id"], name: "index_articles_characteristics_on_article_id", using: :btree
  add_index "articles_characteristics", ["characteristic_id"], name: "index_articles_characteristics_on_characteristic_id", using: :btree

  create_table "articles_patient_groups", id: false, force: true do |t|
    t.integer "article_id"
    t.integer "patient_group_id"
  end

  add_index "articles_patient_groups", ["article_id"], name: "index_articles_patient_groups_on_article_id", using: :btree
  add_index "articles_patient_groups", ["patient_group_id"], name: "index_articles_patient_groups_on_patient_group_id", using: :btree

  create_table "characteristics", force: true do |t|
    t.string   "category"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
  end

  create_table "characteristics_recipes", force: true do |t|
    t.integer "recipe_id"
    t.integer "characteristic_id"
  end

  add_index "characteristics_recipes", ["characteristic_id"], name: "index_characteristics_recipes_on_characteristic_id", using: :btree
  add_index "characteristics_recipes", ["recipe_id"], name: "index_characteristics_recipes_on_recipe_id", using: :btree

  create_table "content_quotas", force: true do |t|
    t.integer  "quality_reviews"
    t.integer  "review_conflicts"
    t.integer  "recipes"
    t.integer  "dietitian_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_quotas", ["dietitian_id"], name: "index_content_quotas_on_dietitian_id", using: :btree

  create_table "dietitians", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dietitians", ["email"], name: "index_dietitians_on_email", unique: true, using: :btree
  add_index "dietitians", ["reset_password_token"], name: "index_dietitians_on_reset_password_token", unique: true, using: :btree

  create_table "dietitians_roles", id: false, force: true do |t|
    t.integer "dietitian_id"
    t.integer "role_id"
  end

  add_index "dietitians_roles", ["dietitian_id", "role_id"], name: "index_dietitians_roles_on_dietitian_id_and_role_id", using: :btree

  create_table "families", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.integer  "head_of_family_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "families", ["head_of_family_id"], name: "index_families_on_head_of_family_id", using: :btree

  create_table "ingredients", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "common_allergen"
  end

  create_table "ingredients_recipes", force: true do |t|
    t.integer  "ingredient_id"
    t.integer  "recipe_id"
    t.string   "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "amount_unit"
    t.boolean  "main_ingredient"
    t.boolean  "optional_ingredient"
    t.string   "display_name"
    t.integer  "position"
  end

  add_index "ingredients_recipes", ["ingredient_id"], name: "index_ingredients_recipes_on_ingredient_id", using: :btree
  add_index "ingredients_recipes", ["recipe_id"], name: "index_ingredients_recipes_on_recipe_id", using: :btree

  create_table "ingredients_recipes_recipe_steps", force: true do |t|
    t.integer "ingredients_recipe_id"
    t.integer "recipe_step_id"
  end

  add_index "ingredients_recipes_recipe_steps", ["ingredients_recipe_id"], name: "index_ingredients_recipes_recipe_steps_on_ingredients_recipe_id", using: :btree
  add_index "ingredients_recipes_recipe_steps", ["recipe_step_id"], name: "index_ingredients_recipes_recipe_steps_on_recipe_step_id", using: :btree

  create_table "marketing_items", force: true do |t|
    t.string   "category"
    t.integer  "order"
    t.text     "content"
    t.integer  "dietitian_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "marketing_itemable_id"
    t.string   "marketing_itemable_type"
    t.integer  "patient_group_id"
  end

  add_index "marketing_items", ["dietitian_id"], name: "index_marketing_items_on_dietitian_id", using: :btree
  add_index "marketing_items", ["marketing_itemable_id", "marketing_itemable_type"], name: "marketing_itemable_id_index", using: :btree
  add_index "marketing_items", ["patient_group_id"], name: "index_marketing_items_on_patient_group_id", using: :btree

  create_table "patient_groups", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.text     "description"
    t.integer  "order"
    t.boolean  "input_option"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patient_groups_recipes", id: false, force: true do |t|
    t.integer "recipe_id"
    t.integer "patient_group_id"
  end

  create_table "patient_groups_users", id: false, force: true do |t|
    t.integer "patient_group_id", null: false
    t.integer "user_id",          null: false
  end

  create_table "quality_reviews", force: true do |t|
    t.integer  "dietitian_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quality_reviewable_id"
    t.string   "quality_reviewable_type"
    t.datetime "date_due_by"
    t.datetime "date_completed_on"
    t.boolean  "passed"
    t.boolean  "completed",               default: false, null: false
    t.datetime "date_started"
    t.integer  "tier",                    default: 1
    t.boolean  "resolved",                default: false
    t.datetime "date_resolved_on"
  end

  add_index "quality_reviews", ["dietitian_id"], name: "index_quality_reviews_on_dietitian_id", using: :btree
  add_index "quality_reviews", ["quality_reviewable_id", "quality_reviewable_type"], name: "quality_reviewable_id_index", using: :btree

  create_table "recipe_steps", force: true do |t|
    t.text     "directions"
    t.integer  "recipe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "group_name"
  end

  add_index "recipe_steps", ["recipe_id"], name: "index_recipe_steps_on_recipe_id", using: :btree

  create_table "recipes", force: true do |t|
    t.string   "name"
    t.integer  "dietitian_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.text     "inspiration"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "image_url"
    t.integer  "serving_size"
    t.string   "prep_time"
    t.string   "cook_time"
    t.string   "difficulty"
    t.integer  "creation_stage"
    t.boolean  "completed",           default: false
    t.boolean  "live_recipe",         default: false, null: false
  end

  create_table "review_conflicts", force: true do |t|
    t.integer  "risk_level"
    t.string   "category"
    t.string   "item"
    t.text     "first_suggestion"
    t.text     "issue"
    t.boolean  "resolved",              default: false
    t.text     "second_suggestion"
    t.text     "third_suggestion"
    t.integer  "review_stage"
    t.integer  "quality_review_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "first_reviewer_id"
    t.integer  "second_reviewer_id"
    t.integer  "third_reviewer_id"
    t.text     "first_reviewer_notes"
    t.text     "second_reviewer_notes"
    t.text     "third_reviewer_notes"
    t.text     "original_entry"
    t.datetime "date_resolved_on"
    t.text     "fourth_suggestion"
    t.text     "fourth_reviewer_notes"
    t.integer  "fourth_reviewer_id"
  end

  add_index "review_conflicts", ["first_reviewer_id"], name: "index_review_conflicts_on_first_reviewer_id", using: :btree
  add_index "review_conflicts", ["fourth_reviewer_id"], name: "index_review_conflicts_on_fourth_reviewer_id", using: :btree
  add_index "review_conflicts", ["second_reviewer_id"], name: "index_review_conflicts_on_second_reviewer_id", using: :btree
  add_index "review_conflicts", ["third_reviewer_id"], name: "index_review_conflicts_on_third_reviewer_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "rooms", force: true do |t|
    t.string   "name"
    t.string   "sessionId"
    t.boolean  "public"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_families", force: true do |t|
    t.integer "user_id"
    t.integer "family_id"
  end

  add_index "user_families", ["family_id"], name: "index_user_families_on_family_id", using: :btree
  add_index "user_families", ["user_id"], name: "index_user_families_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.date     "date_of_birth"
    t.string   "sex"
    t.integer  "height_inches"
    t.integer  "weight_ounces"
  end

  add_index "users", ["date_of_birth"], name: "index_users_on_date_of_birth", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["last_name"], name: "index_users_on_last_name", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
