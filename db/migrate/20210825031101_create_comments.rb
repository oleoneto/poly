class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.uuid :id, primary_key: true
      t.belongs_to :user, null: false, foreign_key: {  on_delete: :cascade }, index: true
      t.string :commentable_type, null: false, index: true
      t.integer :commentable_id, null: false, index: true
      t.boolean :is_private, null: false, default: false
      t.datetime :discarded_at, null: true, index: true

      t.timestamps
    end
  end
end
