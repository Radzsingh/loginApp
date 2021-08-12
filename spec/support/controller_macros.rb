module ControllerMacros
  def create_user
    before(:each) do
      User.create(user_name: "jhondoe", password: "password")
    end
  end

  def login_user
    before(:each) do
      user = User.last
      session[:user_id] = user.id
    end
  end
end
