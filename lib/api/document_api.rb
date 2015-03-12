class Document_API < Grape::API
  resource "documents" do

    # ex) http://localhost:3000/api/v1/books
    desc "returns all documents"
    get do
      Document.all
    end

    desc "return a document"
    params do
      requires :id, type: Integer
      optional :title, type: String
    end
    # http://localhost:3000/api/v1/books/{:id}
    get ':id' do
      Document.find(params[:id])
    end
  end
end