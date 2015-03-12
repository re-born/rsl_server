class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :user_id
      t.text :content
      t.string :title

      t.timestamps null: false
    end
  end
end
