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

ActiveRecord::Schema.define(version: 20150324150948) do

  create_table "document_tags", force: :cascade do |t|
    t.integer  "document_id"
    t.integer  "tag_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "document_tags", ["document_id"], name: "index_document_tags_on_document_id"
  add_index "document_tags", ["tag_id", "document_id"], name: "index_document_tags_on_tag_id_and_document_id", unique: true
  add_index "document_tags", ["tag_id"], name: "index_document_tags_on_tag_id"

  create_table "documents", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "content"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "login_id"
    t.string   "password_digest"
    t.integer  "card_id"
    t.boolean  "admin_flag"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
