class CreateShares < ActiveRecord::Migration[6.1]
  def change
    create_table :shares do |t|
      t.uuid :id, primary_key: true
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :invitee, null: false, index: true, foreign_key: { to_table: :users, on_delete: :cascade }
      t.string :shareable_type, null: false, index: true
      t.integer :shareable_id, null: false, index: true
      t.datetime :discarded_at, null: true, index: true

      t.timestamps
    end

    add_index :shares, [:invitee_id, :shareable_type, :shareable_id], unique: true, name: 'index_unique_shares'
  end
end
