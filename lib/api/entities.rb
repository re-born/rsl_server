module Entities
  class Tag < Grape::Entity
    expose :id, :name
  end

  class Document < Grape::Entity
    expose :id, :content, :title, :user_id, :created_at
    expose :tags, using: Entities::Tag
  end
end