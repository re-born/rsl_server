class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :user_id, null: false
      t.text :content, null: false
      t.string :title, null: false

      t.timestamps null: false
    end
  end
end
