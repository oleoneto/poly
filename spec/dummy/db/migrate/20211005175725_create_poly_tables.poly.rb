# This migration comes from poly (originally 20211005132123)
class CreatePolyTables < ActiveRecord::Migration[6.1]
  def change
    create_table :archives, id: :uuid do |t|
      t.belongs_to :user, null: false, type: :uuid, foreign_key: { on_delete: :cascade }
      t.references :archivable, type: :uuid, polymorphic: true, null: false, index: true
      t.timestamps
      t.index [:user_id, :archivable_id, :archivable_type], name: "index_unique_archive_item"
    end

    create_table :articles, id: :uuid do |t|
      t.belongs_to :user, null: false, type: :uuid, foreign_key: { on_delete: :cascade }, index: true
      t.string :title, null: false, index: true
      t.string :language, null: true, index: true
      t.string :excerpt, null: false, :limit => 144, default: ''
      t.integer :status, null: false, index: true
      t.boolean :is_private, null: false, default: true, index: true
      t.datetime :discarded_at, null: true, index: true
      t.timestamps
    end

    create_table :comments, id: :uuid do |t|
      t.belongs_to :user, null: false, type: :uuid, foreign_key: {  on_delete: :cascade }, index: true
      t.references :commentable, type: :uuid, polymorphic: true, null: false, index: true
      t.boolean :is_private, null: false, default: false
      t.datetime :discarded_at, null: true, index: true
      t.timestamps
    end

    create_table :follows, id: :uuid do |t|
      t.belongs_to :user, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.references :followee, null: false, type: :uuid, index: true, foreign_key: { to_table: :users, on_delete: :cascade }
      t.datetime :discarded_at, null: true, index: true
      t.timestamps
      t.index [:user_id, :followee_id], unique: true, name: 'index_unique_user_follow'
    end

    create_table :reactions, id: :uuid do |t|
      t.belongs_to :user, null: false, type: :uuid, foreign_key: { on_delete: :cascade }, index: true
      t.string :kind, null: false, index: true, limit: 20
      t.references :reactable, type: :uuid, polymorphic: true, null: false, index: true
      t.json :data, null: false, default: {}
      t.boolean :is_private, null: false, default: true, index: true
      t.datetime :discarded_at, null: true, index: true
      t.timestamps
      t.index [:user_id, :kind, :reactable_type, :reactable_id], unique: true, name: 'index_unique_user_reactions'
    end

    create_table :shares, id: :uuid do |t|
      t.belongs_to :user, null: false, type: :uuid, foreign_key: { on_delete: :cascade }
      t.references :invitee, null: false, type: :uuid, index: true, foreign_key: { to_table: :users, on_delete: :cascade }
      t.references :shareable, type: :uuid, polymorphic: true, null: false, index: true
      t.datetime :discarded_at, null: true, index: true  
      t.timestamps
      t.index [:invitee_id, :shareable_type, :shareable_id], unique: true, name: 'index_unique_shares'
    end

    create_table :trashes, id: :uuid do |t|
      t.belongs_to :user, null: false, type: :uuid, foreign_key: { on_delete: :cascade }
      t.references :trashable, type: :uuid, polymorphic: true, null: false, index: true
      t.timestamps
      t.index [:user_id, :trashable_id, :trashable_type], name: "index_unique_trash_item"
    end
  end
end
