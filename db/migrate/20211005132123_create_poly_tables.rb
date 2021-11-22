class CreatePolyTables < ActiveRecord::Migration[6.1]
  def change
    create_table :archives do |t|
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :archivable, polymorphic: true, null: false, index: true
      t.timestamps
      t.index [:user_id, :archivable_id, :archivable_type], name: "index_unique_archive_item"
    end

    create_table :articles do |t|
      t.references :author, null: false, foreign_key: { to_table: :users, on_delete: :cascade }, index: true
      t.string :title, null: false, index: true
      t.string :language, null: true, index: true
      t.string :excerpt, null: false, :limit => 144, default: ''
      t.integer :status, null: false, index: true
      t.json :metadata, null: false, default: '{}'
      t.string :content_hash, null: false
      t.boolean :is_private, null: false, default: true, index: true
      t.datetime :discarded_at, null: true, index: true
      t.timestamps
    end

    create_table :comments do |t|
      t.belongs_to :user, null: false, foreign_key: {  on_delete: :cascade }, index: true
      t.references :commentable, polymorphic: true, null: false, index: true
      t.string :content_hash, null: false
      t.boolean :is_private, null: false, default: false
      t.datetime :discarded_at, null: true, index: true
      t.timestamps
    end

    create_table :follows do |t|
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :followee, null: false, index: true, foreign_key: { to_table: :users, on_delete: :cascade }
      t.datetime :discarded_at, null: true, index: true
      t.timestamps
      t.index [:user_id, :followee_id], unique: true, name: 'index_unique_user_follow'
    end

    create_table :reactions do |t|
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }, index: true
      t.string :kind, null: false, index: true, limit: 20
      t.references :reactable, polymorphic: true, null: false, index: true
      t.json :data, null: false, default: {}
      t.boolean :is_private, null: false, default: true, index: true
      t.datetime :discarded_at, null: true, index: true
      t.timestamps
      t.index [:user_id, :kind, :reactable_type, :reactable_id], unique: true, name: 'index_unique_user_reactions'
    end

    create_table :shares do |t|
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :invitee, null: false, index: true, foreign_key: { to_table: :users, on_delete: :cascade }
      t.references :shareable, polymorphic: true, null: false, index: true
      t.datetime :discarded_at, null: true, index: true  
      t.timestamps
      t.index [:invitee_id, :shareable_type, :shareable_id], unique: true, name: 'index_unique_shares'
    end

    create_table :trashes do |t|
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :trashable, polymorphic: true, null: false, index: true
      t.timestamps
      t.index [:user_id, :trashable_id, :trashable_type], name: "index_unique_trash_item"
    end

    create_table :tags do |t|
      t.string :name, index: true, null: false, unique: true
      t.timestamps
    end

    create_table :taggings do |t|
      t.belongs_to :tag, null: false, foreign_key: { on_delete: :cascade }
      t.references :taggable,  polymorphic: true, null: false, index: true, on_delete: :cascade
      t.timestamps
      t.index [:tag_id, :taggable_id, :taggable_type], name: "index_unique_tag_item"
    end
  end
end
