class DocumentTag < ActiveRecord::Base
  belongs_to :document
  belongs_to :tag

  validates :tag_id, uniqueness: {scope: [:document_id]}
end
