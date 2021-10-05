# This migration comes from poly (originally 20210825031101)
class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments, id: :uuid do |t|
      t.belongs_to :user, null: false, type: :uuid, foreign_key: {  on_delete: :cascade }, index: true
      t.string :commentable_type, null: false, index: true
      t.uuid :commentable_id, null: false, index: true
      t.boolean :is_private, null: false, default: false
      t.datetime :discarded_at, null: true, index: true

      t.timestamps
    end
  end
end
