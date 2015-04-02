class Session < Grape::API
  resource "sessions" do
    desc 'Check Valid Auth Token'
    params do
      requires :access_token, type: String
    end
    get :check do
      access_token = AccessToken.find_by_access_token params[:access_token]
      result = if valid_token?(access_token) then :valid else :invalid end
      present :result, result
    end


    desc "User Login"
    params do
      requires :login_id, type: String
      requires :password, type: String
    end
    # http://localhost:3000/api/sessions
    post do
      user = User.find_by(login_id: params[:login_id])
      return error!('Unauthorized. Invalid or expired token.', 401) unless user.present? && user.authenticate(params[:password])
      puts 'aaa'
      access_token = AccessToken.create(user_id: user.id)
      present access_token, with: Entities::LoginInfo
    end
  end
end