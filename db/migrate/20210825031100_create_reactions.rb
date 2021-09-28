class CreateReactions < ActiveRecord::Migration[6.1]
  def change
    create_table :reactions do |t|
      t.uuid :id, primary_key: true
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }, index: true
      t.enum :type, enum_name: :reaction_type, null: false, index: true
      t.string :reactable_type, null: false, index: true
      t.integer :reactable_id, null: false, index: true
      t.boolean :is_private, null: false, default: true, index: true
      t.datetime :discarded_at, null: true, index: true

      t.timestamps
    end

    add_index :reactions, [:user_id, :type, :reactable_type, :reactable_id], unique: true, name: 'index_unique_user_reactions'
  end
end
