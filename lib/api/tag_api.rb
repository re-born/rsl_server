class Tag_API < Grape::API
  resource "tags" do
    desc "get all tags"
    get do
      Tag.all
    end

    desc "delete tag"
    params do
      requires :id, type: Integer
    end
    delete ':id' do
      puts params.id
      tag = Tag.find(params[:id])
      table_cols = DocumentsTag.where(tag_id: params.id)
      tag.destroy
      table_cols.each do |col|
        col.destroy
      end
    end
  end
end