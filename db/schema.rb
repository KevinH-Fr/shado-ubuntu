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

ActiveRecord::Schema[7.0].define(version: 2023_06_20_160837) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_parameters", force: :cascade do |t|
    t.integer "remuneration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "associations", force: :cascade do |t|
    t.integer "athlete_id", null: false
    t.integer "fan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["athlete_id"], name: "index_associations_on_athlete_id"
    t.index ["fan_id"], name: "index_associations_on_fan_id"
  end

  create_table "athletes", force: :cascade do |t|
    t.string "name"
    t.string "discipline"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "sport_id"
    t.index ["sport_id"], name: "index_athletes_on_sport_id"
    t.index ["user_id"], name: "index_athletes_on_user_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "periodicity"
    t.decimal "subscription"
    t.integer "target"
    t.date "start"
    t.date "end"
    t.integer "athlete_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "thankyounote"
    t.index ["athlete_id"], name: "index_campaigns_on_athlete_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.integer "user_id", null: false
    t.string "commentable_type", null: false
    t.integer "commentable_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["deleted_at"], name: "index_comments_on_deleted_at"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "fans", force: :cascade do |t|
    t.string "pseudo"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_fans_on_user_id"
  end

  create_table "friends", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string "recipient_type", null: false
    t.integer "recipient_id", null: false
    t.string "type", null: false
    t.json "params"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.string "location"
    t.text "content"
    t.integer "athlete_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "fan_id"
    t.integer "cached_votes_total", default: 0
    t.integer "cached_votes_score", default: 0
    t.integer "cached_votes_up", default: 0
    t.integer "cached_votes_down", default: 0
    t.integer "cached_weighted_score", default: 0
    t.integer "cached_weighted_total", default: 0
    t.float "cached_weighted_average", default: 0.0
    t.boolean "exclusif"
    t.index ["athlete_id"], name: "index_posts_on_athlete_id"
    t.index ["fan_id"], name: "index_posts_on_fan_id"
  end

  create_table "sports", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "campaign_id", null: false
    t.integer "fan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "brut"
    t.decimal "net"
    t.index ["campaign_id"], name: "index_subscriptions_on_campaign_id"
    t.index ["fan_id"], name: "index_subscriptions_on_fan_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.string "votable_type"
    t.integer "votable_id"
    t.string "voter_type"
    t.integer "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_type", "voter_id"], name: "index_votes_on_voter"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "associations", "athletes"
  add_foreign_key "associations", "fans"
  add_foreign_key "athletes", "sports"
  add_foreign_key "athletes", "users"
  add_foreign_key "campaigns", "athletes"
  add_foreign_key "comments", "users"
  add_foreign_key "fans", "users"
  add_foreign_key "posts", "athletes"
  add_foreign_key "posts", "fans"
  add_foreign_key "subscriptions", "campaigns"
  add_foreign_key "subscriptions", "fans"
end
