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

ActiveRecord::Schema.define(version: 20170210072800) do

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "token"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider"], name: "index_authentications_on_provider"
    t.index ["uid"], name: "index_authentications_on_uid"
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "custom_audiences", force: :cascade do |t|
    t.string   "fb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["fb_id"], name: "index_custom_audiences_on_fb_id"
    t.index ["user_id"], name: "index_custom_audiences_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workflows", force: :cascade do |t|
    t.integer  "custom_audience_id"
    t.string   "mp_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["custom_audience_id"], name: "index_workflows_on_custom_audience_id"
    t.index ["mp_id"], name: "index_workflows_on_mp_id"
  end

end
