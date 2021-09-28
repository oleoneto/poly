class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.uuid :id, primary_key: true
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }, index: true
      t.string :title, null: false, index: true
      t.string :language, null: true, index: true
      t.boolean :is_private, null: false, default: true, index: true
      t.datetime :discarded_at, null: true, index: true

      t.timestamps
    end
  end
end
