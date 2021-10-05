# This migration comes from poly (originally 20210829070140)
class CreateTrashes < ActiveRecord::Migration[6.1]
  def change
    create_table :trashes, id: :uuid do |t|
      t.belongs_to :user, null: false, type: :uuid, foreign_key: { on_delete: :cascade }
      t.string :trashable_type, null: false, index: true
      t.uuid :trashable_id, null: false, index: true
      t.timestamps
    end

    add_index :trashes, [:user_id, :trashable_id, :trashable_type], name: "index_unique_trash_item"
  end
end
