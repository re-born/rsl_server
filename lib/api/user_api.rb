class User_API < Grape::API
  resource "users" do |variable|
    helpers do
      def document_params
        ActionController::Parameters.new(params).permit(:login_id, :name, :password, :password_confirmation, :card_id)
      end
    end

    desc "get all user list"
    #/api/users/
    get do
      users = User.all
      present users, with: Entities::User
    end

    desc "Get Single User."
    params {}
    get ':id', requirements: { id: /[0-9]*/ } do
      user = User.find params[:id]
      present user, with: Entities::User
    end

    desc "create user"
    params do
      requires :login_id, type: String
      requires :name, type: String
      requires :password, type: String
      requires :password_confirmation, type: String
      optional :auth_flag, type: Boolean, default: false
      optional :card_id, type: Integer
    end
    post do
      user = User.new(document_params)
      user.save
    end

    desc "edit user"
    params do
      requires :login_id, type: String
      requires :name, type: String
      requires :password, type: String
      requires :password_confirmation, type: String
      optional :auth_flag, type: Boolean, default: false
      optional :card_id, type: Integer
    end
    patch do
      user = User.new(document_params)
      user.save
    end
  end
end