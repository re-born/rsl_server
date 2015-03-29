class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, unique: true
      t.string :login_id, unique: true
      t.string :password_digest
      t.integer :card_id, unique: true
      t.boolean :admin_flag

      t.timestamps null: false
    end
  end
end
