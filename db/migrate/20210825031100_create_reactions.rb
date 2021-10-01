class CreateReactions < ActiveRecord::Migration[6.1]
  def change
    create_table :reactions, id: :uuid do |t|
      t.belongs_to :user, null: false, type: :uuid, foreign_key: { on_delete: :cascade }, index: true
      t.string :type, null: false, index: true
      t.string :reactable_type, null: false, index: true
      t.uuid :reactable_id, null: false, index: true
      t.json :data, null: false, default: {}
      t.boolean :is_private, null: false, default: true, index: true
      t.datetime :discarded_at, null: true, index: true

      t.timestamps
    end

    add_index :reactions, [:user_id, :type, :reactable_type, :reactable_id], unique: true, name: 'index_unique_user_reactions'
  end
end
