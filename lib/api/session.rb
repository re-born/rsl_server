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
        sign_in user
      else
        'error'
      end
    end
  end
end