class GeneralAPI < Grape::API
  before do
    authenticate!
  end

  mount Document_API
  mount Tag_API
  mount User_API
end