class CreateArchives < ActiveRecord::Migration[6.1]
  def change
    create_table :archives, id: :uuid do |t|
      t.belongs_to :user, null: false, type: :uuid, foreign_key: { on_delete: :cascade }
      t.string :archivable_type, null: false, index: true
      t.uuid :archivable_id, null: false, index: true
      t.timestamps
    end

    add_index :archives, [:user_id, :archivable_id, :archivable_type], name: "index_unique_archive_item"
  end
end
