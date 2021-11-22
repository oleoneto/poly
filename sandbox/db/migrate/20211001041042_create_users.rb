class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.boolean :is_admin, null: false, default: false
      t.timestamps

      t.index :is_admin
    end
  end
end
