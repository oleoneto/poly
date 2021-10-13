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

ActiveRecord::Schema.define(version: 2021_10_05_175725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "action_mailbox_inbound_emails", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.string "message_id", null: false
    t.string "message_checksum", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["message_id", "message_checksum"], name: "index_action_mailbox_inbound_emails_uniqueness", unique: true
  end

  create_table "action_text_rich_texts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "archives", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "archivable_type", null: false
    t.uuid "archivable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["archivable_type", "archivable_id"], name: "index_archives_on_archivable"
    t.index ["user_id", "archivable_id", "archivable_type"], name: "index_unique_archive_item"
    t.index ["user_id"], name: "index_archives_on_user_id"
  end

  create_table "articles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "author_id", null: false
    t.string "title", null: false
    t.string "language"
    t.string "excerpt", limit: 144, default: "", null: false
    t.integer "status", null: false
    t.boolean "is_private", default: true, null: false
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_articles_on_author_id"
    t.index ["discarded_at"], name: "index_articles_on_discarded_at"
    t.index ["is_private"], name: "index_articles_on_is_private"
    t.index ["language"], name: "index_articles_on_language"
    t.index ["status"], name: "index_articles_on_status"
    t.index ["title"], name: "index_articles_on_title"
  end

  create_table "comments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "commentable_type", null: false
    t.uuid "commentable_id", null: false
    t.boolean "is_private", default: false, null: false
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["discarded_at"], name: "index_comments_on_discarded_at"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "follows", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "followee_id", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["discarded_at"], name: "index_follows_on_discarded_at"
    t.index ["followee_id"], name: "index_follows_on_followee_id"
    t.index ["user_id", "followee_id"], name: "index_unique_user_follow", unique: true
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "reactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "kind", limit: 20, null: false
    t.string "reactable_type", null: false
    t.uuid "reactable_id", null: false
    t.json "data", default: {}, null: false
    t.boolean "is_private", default: true, null: false
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["discarded_at"], name: "index_reactions_on_discarded_at"
    t.index ["is_private"], name: "index_reactions_on_is_private"
    t.index ["kind"], name: "index_reactions_on_kind"
    t.index ["reactable_type", "reactable_id"], name: "index_reactions_on_reactable"
    t.index ["user_id", "kind", "reactable_type", "reactable_id"], name: "index_unique_user_reactions", unique: true
    t.index ["user_id"], name: "index_reactions_on_user_id"
  end

  create_table "shares", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "invitee_id", null: false
    t.string "shareable_type", null: false
    t.uuid "shareable_id", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["discarded_at"], name: "index_shares_on_discarded_at"
    t.index ["invitee_id", "shareable_type", "shareable_id"], name: "index_unique_shares", unique: true
    t.index ["invitee_id"], name: "index_shares_on_invitee_id"
    t.index ["shareable_type", "shareable_id"], name: "index_shares_on_shareable"
    t.index ["user_id"], name: "index_shares_on_user_id"
  end

  create_table "trashes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "trashable_type", null: false
    t.uuid "trashable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["trashable_type", "trashable_id"], name: "index_trashes_on_trashable"
    t.index ["user_id", "trashable_id", "trashable_type"], name: "index_unique_trash_item"
    t.index ["user_id"], name: "index_trashes_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "archives", "users", on_delete: :cascade
  add_foreign_key "articles", "users", column: "author_id", on_delete: :cascade
  add_foreign_key "comments", "users", on_delete: :cascade
  add_foreign_key "follows", "users", column: "followee_id", on_delete: :cascade
  add_foreign_key "follows", "users", on_delete: :cascade
  add_foreign_key "reactions", "users", on_delete: :cascade
  add_foreign_key "shares", "users", column: "invitee_id", on_delete: :cascade
  add_foreign_key "shares", "users", on_delete: :cascade
  add_foreign_key "trashes", "users", on_delete: :cascade
end
