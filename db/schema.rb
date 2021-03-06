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

ActiveRecord::Schema.define(version: 20150426082426) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "idea_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["idea_id"], name: "index_comments_on_idea_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "ideas", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ideas", ["user_id"], name: "index_ideas_on_user_id", using: :btree

  create_table "invitations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.string   "key"
    t.string   "recipient"
    t.boolean  "has_account"
    t.boolean  "accepted"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "array"
  end

  add_index "invitations", ["team_id"], name: "index_invitations_on_team_id", using: :btree
  add_index "invitations", ["user_id"], name: "index_invitations_on_user_id", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "memberships", ["team_id"], name: "index_memberships_on_team_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "pins", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "idea_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pins", ["idea_id"], name: "index_pins_on_idea_id", using: :btree
  add_index "pins", ["user_id"], name: "index_pins_on_user_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "bio"
    t.string   "handle"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "github"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "avatar_url"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "shares", force: :cascade do |t|
    t.integer  "idea_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "shares", ["idea_id"], name: "index_shares_on_idea_id", using: :btree
  add_index "shares", ["team_id"], name: "index_shares_on_team_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "owner"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "comments", "ideas"
  add_foreign_key "comments", "users"
  add_foreign_key "ideas", "users"
  add_foreign_key "invitations", "teams"
  add_foreign_key "invitations", "users"
  add_foreign_key "memberships", "teams"
  add_foreign_key "memberships", "users"
  add_foreign_key "pins", "ideas"
  add_foreign_key "pins", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "shares", "ideas"
  add_foreign_key "shares", "teams"
end
