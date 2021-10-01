class CreateShares < ActiveRecord::Migration[6.1]
  def change
    create_table :shares, id: :uuid do |t|
      t.belongs_to :user, null: false, type: :uuid, foreign_key: { on_delete: :cascade }
      t.references :invitee, null: false, type: :uuid, index: true, foreign_key: { to_table: :users, on_delete: :cascade }
      t.string :shareable_type, null: false, index: true
      t.uuid :shareable_id, null: false, index: true
      t.datetime :discarded_at, null: true, index: true

      t.timestamps
    end

    add_index :shares, [:invitee_id, :shareable_type, :shareable_id], unique: true, name: 'index_unique_shares'
  end
end
