class Tag_API < Grape::API
  resource "tags" do
    helpers do

    end

    desc "get all tags"
    # /api/tags/
    get do
      Tag.all
    end

    desc "return searched document"
    params do
      requires :tag_id, type: Integer
    end
    # http://localhost:3000/api/tags/{:tag_id}/document
    get ':tag_id/documents' do
      document = Document.includes(:tags).where(tags: {id: params[:tag_id]})
      present document, with: Entities::Document
      # 以下だとSQLがドキュメント毎に走る=重い
      # tag = Tag.find(params[:tag_id])
      # present tag.documents, with: Entities::Document
    end
    # desc "delete tag"
    # params do
    #   requires :id, type: Integer
    # end
    # delete ':id' do
    #   puts params.id
    #   tag = Tag.find(params[:id])
    #   table_cols = DocumentsTag.where(tag_id: params.id)
    #   tag.destroy
    #   table_cols.each do |col|
    #     col.destroy
    #   end
    # end
  end
end