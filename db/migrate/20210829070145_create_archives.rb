class CreateArchives < ActiveRecord::Migration[6.1]
  def change
    create_table :archives do |t|
      t.uuid :id, primary_key: true
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }
      t.integer :archivable_id, null: false, index: true
      t.string :archivable_type, null: false, index: true
      t.timestamps
    end

    add_index :archives, [:user_id, :archivable_id, :archivable_type], name: "index_unique_archive_item"
  end
end
