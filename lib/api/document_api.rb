class Document_API < Grape::API
  resource "documents" do
    helpers do
      def document_params
        ActionController::Parameters.new(params).permit(:user_id, :content, :title, :tags)
      end

      def save_tags(document,tag_name)
        tag = Tag.where(name: tag_name).first_or_create()
        table_obj = DocumentTag.create(tag_id: tag.id, document_id: document.id)
      end
    end

    # http://localhost:3000/api/document
    desc "returns all documents"
    get do
      document = Document.includes(:tags)
      present document, with: Entities::Document
    end

    desc "return a document"
    params {}
    # http://localhost:3000/api/document/{:id}
    get ':id' , requirements: { id: /[0-9]*/ } do
      document = Document.find(params[:id])
      present document, with: Entities::Document
    end

    desc "create a document"
    params do
      requires :content, type: String
      requires :title, type: String
      requires :user_id, type: Integer
      optional :tags, type: Array
    end
    # http://localhost:3000/api/document
    post do
      document = Document.new(document_params)
      if document.save
        params[:tags].each do |tag_name|
          save_tags(document,tag_name)
        end
        present document, Entities::Document
      else
        error!(document.errors.full_messages, 400)
      end
    end

    desc "edit a document"
    params do
      optional :content, type: String
      optional :title, type: String
      requires :user_id, type: String
      optional :tags, type: Array
    end
    # http://localhost:3000/api/document
    patch ':id', requirements: { id: /[0-9]*/ } do
      document = Document.find(params[:id])
      error!("you can not edit this docs", 403) unless document.user_id == current_user.id
      document.content = params[:content] if params[:content].present?
      document.title = params[:title] if params[:title].present?
      if params[:tags].present?
        document.document_tags.each {|target| target.delete}
        params[:tags].each do |tag_name|
          save_tags(document,tag_name)
        end
      end
      if document.save
        present document, Entities::Document
      else
        return {error: document.errors.full_messages}
      end
    end

    desc "delete a document"
    params {}
    delete ':id', requirements: { id: /[0-9]*/ } do
      document = Document.find(params[:id])
      DocumentTag.delete_all(document_id: params[:id])
      document.destroy
    end
  end
end