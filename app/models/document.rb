class Document < ActiveRecord::Base
  require 'lib'
  include Notification

  after_create :notify_new_document

  has_many :document_tags
  has_many :tags, through: :document_tags
  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true

  private

  def notify_new_document
    message = <<"EOS"
#{user.name} wrote new wiki
Look at #{url}
EOS
    slack_notify(message, '#dev')
  end

  def url
    "https://rsl-wiki.l-u-l.tk/#/wiki/#{id}"
  end

end
