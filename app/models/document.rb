class Document < ActiveRecord::Base
  has_many :document_tags
  has_many :tags, through: :document_tags

  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
end
