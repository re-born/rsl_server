class User < ActiveRecord::Base
  before_save { self.login_id = login_id.downcase }
  validates :name,  presence: true, length: { maximum: 50 }, uniqueness: true
  validates :login_id, presence: true, uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }
end
