module APIHelper
  extend Grape::API::Helpers

  PRIVATE_TOKEN_PARAM = :access_token
  PRIVATE_TOKEN_HEADER = "Rsl-Http-Access-Token"

  def valid_token?(access_token)
    access_token && !access_token.expired?
  end

  def authenticate!
    error!('Unauthorized. Invalid or expired token.', 401) unless current_user
  end

  def current_user
    # トークンを検索
    token = authenticate_token
    access_token = AccessToken.find_by_access_token token
    if access_token && !access_token.expired?
      @current_user = User.find(access_token.user_id)
    else
      false
    end
  end

  def authenticate_token
    (headers[PRIVATE_TOKEN_HEADER] || params[PRIVATE_TOKEN_PARAM]).to_s
  end
end