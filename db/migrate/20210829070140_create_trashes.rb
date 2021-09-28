class CreateTrashes < ActiveRecord::Migration[6.1]
  def change
    create_table :trashes do |t|
      t.uuid :id, primary_key: true
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }
      t.integer :trashable_id, null: false, index: true
      t.string :trashable_type, null: false, index: true
      t.timestamps
    end

    add_index :trashes, [:user_id, :trashable_id, :trashable_type], name: "index_unique_trash_item"
  end
end
