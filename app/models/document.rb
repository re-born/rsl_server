class Document < ActiveRecord::Base
  has_many :document_tags
  has_many :tags, through: :document_tags
end
