class Document_API < Grape::API
  resource "documents" do
    helpers do
      def document_params
        ActionController::Parameters.new(params).permit(:user_id, :content, :title)
      end
    end
    # ex) http://localhost:3000/api/v1/document
    desc "returns all documents"
    get do
      Document.all
    end

    desc "return a document"
    params do
      requires :id, type: Integer
    end
    # http://localhost:3000/api/document/{:id}
    get ':id' do
      Document.find(params[:id])
    end

    desc "create a document"
    params do
      requires :content, type: String
      requires :title, type: String
      requires :user_id, type: Integer
    end
    # http://localhost:3000/api/v1/document
    post do
      document = Document.new(document_params)
      document.save
    end

    desc "edit a document"
    params do
      optional :content, type: String
      optional :title, type: String
    end
    # http://localhost:3000/api/v1/document
    put ':id' do
      document = Document.find(params[:id])
      document.content = params[:content] if params[:content].present?
      document.title = params[:title] if params[:title].present?
      document.save
    end

    desc "edit a document"
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