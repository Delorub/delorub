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

ActiveRecord::Schema.define(version: 20170726203135) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "billing_reply_packs", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.float "cost"
    t.integer "amount"
    t.integer "spent", default: 0, null: false
    t.boolean "available", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "billing_reply_subscriptions", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.float "cost"
    t.datetime "active_from"
    t.datetime "active_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "billing_task_autorefreshes", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "task_id"
    t.float "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "billing_task_blogs", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "task_id"
    t.float "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "billing_task_colors", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "task_id"
    t.float "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "billing_task_packs", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.float "cost"
    t.integer "amount"
    t.integer "spent", default: 0, null: false
    t.boolean "available", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "billing_task_subscriptions", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.float "cost"
    t.datetime "active_from"
    t.datetime "active_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "billing_transfer_manually", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "admin_id"
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "title"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
    t.integer "children_count"
    t.string "photo"
    t.integer "position"
    t.string "slug"
    t.text "settings"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "categories_profiles", id: :serial, force: :cascade do |t|
    t.integer "profile_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "certificates", id: :serial, force: :cascade do |t|
    t.string "file"
    t.integer "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_certificates_on_profile_id"
  end

  create_table "coming_soon_requests", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "visitor_session_id"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "parent_id"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "text"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "contract_categories", id: :serial, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contract_templates", id: :serial, force: :cascade do |t|
    t.string "title"
    t.integer "category_id"
    t.text "markup"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contracts", id: :serial, force: :cascade do |t|
    t.integer "template_id"
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deals", id: :serial, force: :cascade do |t|
    t.integer "task_id"
    t.integer "profile_id"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "help_answers", id: :serial, force: :cascade do |t|
    t.integer "help_category_id"
    t.string "title"
    t.text "content"
    t.text "synonyms"
    t.integer "position"
  end

  create_table "help_categories", id: :serial, force: :cascade do |t|
    t.string "title"
    t.integer "position"
  end

  create_table "help_questions", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "content"
    t.text "reply"
    t.boolean "answered", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "replied_at"
  end

  create_table "news", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
  end

  create_table "notifications", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "message"
    t.string "state"
    t.text "params"
    t.string "notifiable_type"
    t.integer "notifiable_id"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pages", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.text "content"
    t.boolean "draft"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "place_type_names", id: :serial, force: :cascade do |t|
    t.integer "level"
    t.integer "code"
    t.string "name"
    t.string "full_name"
    t.string "alt_name"
    t.boolean "after_place_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "places", id: :serial, force: :cascade do |t|
    t.string "fias_aoguid"
    t.string "name"
    t.string "full_name"
    t.integer "level"
    t.integer "place_type"
    t.integer "place_type_name_id"
    t.integer "parent_place_id"
    t.integer "region_place_id"
    t.boolean "is_region_center"
    t.boolean "is_center"
    t.boolean "custom"
  end

  create_table "portfolio_items", id: :serial, force: :cascade do |t|
    t.integer "profile_id"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_portfolio_items_on_profile_id"
  end

  create_table "profiles", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "work_type"
    t.boolean "have_car"
    t.text "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "price_type"
    t.integer "price_hourly"
    t.integer "price_project"
    t.boolean "have_instrument", default: false
    t.boolean "can_departure", default: false
    t.boolean "working_all_time", default: false
    t.string "working_days"
    t.integer "working_hours_from"
    t.integer "working_hours_to"
    t.integer "rating_votes_count"
    t.integer "rating_votes_sum"
    t.float "rating"
    t.boolean "notifications_email_enabled", default: true
  end

  create_table "replies", id: :serial, force: :cascade do |t|
    t.integer "task_id"
    t.integer "user_id"
    t.string "status"
    t.text "content"
    t.string "billable_type"
    t.integer "billable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "aasm_state"
    t.index ["aasm_state"], name: "index_replies_on_aasm_state"
  end

  create_table "services", id: :serial, force: :cascade do |t|
    t.integer "profile_id"
    t.string "title"
    t.integer "price"
    t.string "price_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sms_confirmations", id: :serial, force: :cascade do |t|
    t.string "token"
    t.string "phone"
    t.string "code"
    t.boolean "accepted", default: false
    t.integer "attempts", default: 0
    t.datetime "last_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_files", id: :serial, force: :cascade do |t|
    t.string "file"
    t.integer "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_task_files_on_task_id"
  end

  create_table "tasks", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.integer "category_id", null: false
    t.integer "user_id", null: false
    t.string "price_type", null: false
    t.string "price_scale"
    t.integer "price_exact"
    t.integer "price_from"
    t.integer "price_to"
    t.integer "place_id"
    t.float "place_lat"
    t.float "place_long"
    t.string "place_address"
    t.string "date_type", null: false
    t.string "contract_type"
    t.text "description"
    t.boolean "notify_email"
    t.boolean "colored", default: false
    t.string "billable_type"
    t.integer "billable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "date_actual"
    t.datetime "date_interval_from"
    t.datetime "date_interval_to"
    t.string "aasm_state"
    t.index ["aasm_state"], name: "index_tasks_on_aasm_state"
  end

  create_table "user_billing_logs", id: :serial, force: :cascade do |t|
    t.float "sum"
    t.integer "user_id"
    t.string "billable_type"
    t.integer "billable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_omniauth_relations", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "provider"
    t.string "external_id"
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "external_id"], name: "index_user_omniauth_relations_on_provider_and_external_id", unique: true
    t.index ["user_id"], name: "index_user_omniauth_relations_on_user_id"
  end

  create_table "user_permissions", id: :serial, force: :cascade do |t|
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "user_temporary_photos", id: :serial, force: :cascade do |t|
    t.string "photo"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "middle_name"
    t.string "phone"
    t.string "email"
    t.date "birthday"
    t.integer "profile_id"
    t.integer "free_tasks_published", default: 0, null: false
    t.integer "free_replies_published", default: 0, null: false
    t.decimal "balance", precision: 10, scale: 2, default: "0.0", null: false
    t.string "photo"
    t.boolean "phone_confirmed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "access_token"
    t.integer "place_id"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["place_id"], name: "index_users_on_place_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vacancies", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "small_description"
    t.text "description"
    t.integer "position"
    t.boolean "archive", default: false
  end

  create_table "visitor_session_actions", force: :cascade do |t|
    t.bigint "visitor_session_id"
    t.string "action_type"
    t.string "identity"
    t.string "keyword"
    t.string "url"
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["visitor_session_id"], name: "index_visitor_session_actions_on_visitor_session_id"
  end

  create_table "visitor_sessions", force: :cascade do |t|
    t.string "ip"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
