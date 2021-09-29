class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.uuid :id, primary_key: true
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :followee, null: false, index: true, foreign_key: { to_table: :users, on_delete: :cascade }
      t.datetime :discarded_at, null: true, index: true

      t.timestamps
    end

    add_index :follows, [:user_id, :followee_id], unique: true, name: 'index_unique_user_follow'
  end
end
