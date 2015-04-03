class CreateAccessTokens < ActiveRecord::Migration
  def change
    create_table :access_tokens do |t|
      t.string :access_token, null: false
      t.datetime :expires_at
      t.integer :user_id, null: false

      t.timestamps null: false
    end
    add_index :access_tokens, ["user_id"], unique: false
    add_index :access_tokens, ["access_token"], unique: true
  end
end
