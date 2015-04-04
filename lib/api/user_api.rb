class User_API < Grape::API
  resource "users" do |variable|
    helpers do
      def document_params
        ActionController::Parameters.new(params).permit(:login_id, :name, :password, :password_confirmation, :admin_flag, :card_id)
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
      optional :admin_flag, type: Boolean, default: false
      optional :card_id, type: Integer
    end
    post do
      user = User.new(document_params)
      unless user.save
        error!("error",400)
      end
    end

    desc "edit user"
    params do
      optional :name, type: String
      optional :password, type: String
      optional :password_confirmation, type: String
      optional :admin_flag, type: Boolean, default: false
      optional :card_id, type: Integer
    end
    patch ':id', requirements: { id: /[0-9]*/ } do
      user = User.find(params[:id])
      error!("you can not edit this user", 403) unless user.id == current_user.id
      user.name = params[:name] if params[:name].present?
      user.password = params[:password] if params[:password].present?
      user.password_confirmation = params[:password_confirmation] if params[:password_confirmation].present?
      user.admin_flag = params[:admin_flag] if params[:admin_flag].present?
      user.card_id = params[:card_id] if params[:card_id].present?
      if user.save
        present user, Entities::User
      else
        error!("error",400)
      end
    end
  end
end