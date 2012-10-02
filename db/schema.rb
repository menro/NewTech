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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121001205235) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.string   "namespace"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"

  create_table "cities", :force => true do |t|
    t.integer  "county_id"
    t.string   "name"
    t.string   "state"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "cities", ["county_id"], :name => "index_cities_on_county_id"
  add_index "cities", ["name"], :name => "index_cities_on_name"

  create_table "companies", :force => true do |t|
    t.integer  "user_id"
    t.integer  "employees_type_id"
    t.integer  "investments_type_id"
    t.string   "name"
    t.string   "permalink"
    t.boolean  "hiring"
    t.boolean  "enabled"
    t.boolean  "presented"
    t.date     "presentation_date"
    t.string   "homepage_url"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "jobs_url"
    t.string   "founded_year"
    t.string   "email_address"
    t.string   "phone_number"
    t.text     "description"
    t.text     "overview"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "companies", ["employees_type_id"], :name => "index_companies_on_employees_type_id"
  add_index "companies", ["enabled"], :name => "index_companies_on_enabled"
  add_index "companies", ["founded_year"], :name => "index_companies_on_founded_year"
  add_index "companies", ["hiring"], :name => "index_companies_on_hiring"
  add_index "companies", ["investments_type_id"], :name => "index_companies_on_investments_type_id"
  add_index "companies", ["user_id"], :name => "index_companies_on_user_id"

  create_table "companies_tags", :id => false, :force => true do |t|
    t.integer "company_id"
    t.integer "tag_id"
  end

  add_index "companies_tags", ["company_id"], :name => "index_companies_tags_on_company_id"
  add_index "companies_tags", ["tag_id"], :name => "index_companies_tags_on_tag_id"

  create_table "counties", :force => true do |t|
    t.string   "name"
    t.string   "state"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "counties", ["name"], :name => "index_counties_on_name"

  create_table "employees_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "employees_types", ["name"], :name => "index_employees_types_on_name"

  create_table "events", :force => true do |t|
    t.string   "title"
    t.string   "preview"
    t.datetime "start_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "events", ["start_at"], :name => "index_events_on_start_at"

  create_table "investments_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "investments_types", ["name"], :name => "index_investments_types_on_name"

  create_table "offices", :force => true do |t|
    t.integer  "company_id"
    t.integer  "city_id"
    t.string   "description"
    t.string   "address1"
    t.string   "address2"
    t.string   "zip_code"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "offices", ["city_id"], :name => "index_offices_on_city_id"
  add_index "offices", ["company_id"], :name => "index_offices_on_company_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tags", ["code"], :name => "index_tags_on_code"
  add_index "tags", ["name"], :name => "index_tags_on_name"

  create_table "users", :force => true do |t|
    t.string   "username",               :default => "", :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["role_id"], :name => "index_users_roles_on_role_id"
  add_index "users_roles", ["user_id"], :name => "index_users_roles_on_user_id"

end
