module Entities
  class Tag < Grape::Entity
    expose :id, :name
  end

  class Document < Grape::Entity
    expose :id, :content, :title, :user_id, :created_at
    expose :tags, using: Entities::Tag
  end

  class User < Grape::Entity
    expose :id, :name, :card_id ,:created_at
  end
end