module APIHelper
  extend Grape::API::Helpers

  PRIVATE_TOKEN_PARAM = :auth_token
  PRIVATE_TOKEN_HEADER = 'X-Http-Access-Token'

  def authenticate!
    error!('Unauthorized. Invalid or expired token.', 401) unless current_user
  end

  def current_user
    # トークンを検索
    token = authenticate_token
    access_token = AccessToken.find_by_access_token(params[token])
    if access_token && !token.expired?
      @current_user = User.find(token.user_id)
    else
      false
    end
  end

  def authenticate_token
    (headers[PRIVATE_TOKEN_HEADER] || params[PRIVATE_TOKEN_PARAM]).to_s
  end
end