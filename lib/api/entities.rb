module Entities
  class Tag < Grape::Entity
    expose :id, :name
  end

  class User < Grape::Entity
    expose :id, :name, :card_id, :created_at
  end

  class Document < Grape::Entity
    expose :id, :content, :title, :user_id, :created_at
    expose :tags, using: Entities::Tag
    expose :user, using: Entities::User
  end

  class LoginInfo < Grape::Entity
    expose :access_token
    expose :user, using: Entities::User
  end
end