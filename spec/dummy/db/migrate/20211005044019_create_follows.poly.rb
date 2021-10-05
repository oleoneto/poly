# This migration comes from poly (originally 20210730014844)
class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows, id: :uuid do |t|
      t.belongs_to :user, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.references :followee, null: false, type: :uuid, index: true, foreign_key: { to_table: :users, on_delete: :cascade }
      t.datetime :discarded_at, null: true, index: true

      t.timestamps
    end

    add_index :follows, [:user_id, :followee_id], unique: true, name: 'index_unique_user_follow'
  end
end
