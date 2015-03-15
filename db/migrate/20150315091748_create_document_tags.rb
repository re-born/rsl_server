class CreateDocumentTags < ActiveRecord::Migration
  def change
    create_table :document_tags do |t|
      t.references :document, index: true
      t.integer :document_id
      t.references :tag, index: true
      t.integer :tag_id

      t.timestamps null: false
    end
  end
end
