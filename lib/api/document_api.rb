class Document_API < Grape::API
  resource "documents" do
    helpers do
      def document_params
        ActionController::Parameters.new(params).permit(:user_id, :content, :title, :tags)
      end
      def document_include(document)
        document = document.includes :tags
      end
    end
    # ex) http://localhost:3000/api/document
    desc "returns all documents"
    get do
      document = Document.all
      document_include document
      present document, with: Entities::Document
    end

    desc "return a document"
    params do
      requires :id, type: Integer
    end
    # http://localhost:3000/api/document/{:id}
    get ':id' do
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
    # http://localhost:3000/api/v1/document
    post do
      document = Document.new(document_params)
      if document.save
        tags = params[:tags]
        tags.each do |tag|
          is_tag = Tag.find_by(name: tag)
          unless is_tag
            tag_obj = Tag.new(name: tag)
            tag_obj.save
            table_obj = DocumentTag.new(tag_id: tag_obj.id, document_id: document.id)
            table_obj.save
          else
            table_obj = DocumentTag.new(tag_id: is_tag.id, document_id: document.id)
            table_obj.save
          end
        end
      else
        "error"
      end
    end

    desc "edit a document"
    params do
      optional :content, type: String
      optional :title, type: String
      optional :tags, type: Array
    end
    # http://localhost:3000/api/v1/document
    patch ':id' do
      document = Document.find(params[:id])
      document.content = params[:content] if params[:content].present?
      document.title = params[:title] if params[:title].present?
      document.save
    end

    desc "delete a document"
    params do
      requires :id, type: Integer
    end
    # http://localhost:3000/api/v1/document
    delete ':id' do
      document = Document.find(params[:id])
      document.destroy
    end
  end
end