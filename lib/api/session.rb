class Session < Grape::API
  resource "sessions" do
    desc "User Login"
    params do
      requires :login_id, type: String
      requires :password, type: String
    end
    # http://localhost:3000/api/sessions
    post do
      user = User.find_by(login_id: params[:login_id])
      if user && user.authenticate(params[:password])
        access_token = AccessToken.create(user_id: user.id)
        present access_token, with: Entities::LoginInfo
      else
        error!('Unauthorized.', 401)
      end
    end
  end
end