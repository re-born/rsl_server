require_relative "helpers"
class API < Grape::API

  # APIアクセスに接頭語を不可
  # ex) http://localhost:3000/api
  prefix "api"

  # 未指定の場合にJSONで返すように変更（URLで指定可能）
  format :json

  helpers APIHelper
  mount User_API
  mount Session
  mount GeneralAPI
end