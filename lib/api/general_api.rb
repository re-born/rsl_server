class GeneralAPI < Grape::API
  before do
    authenticate!
  end

  mount Document_API
  mount Tag_API
end