class UsersController < ApplicationController
  # POST /signup
  # return authenticated token upon signup
  skip_before_action :authorize_request
  
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(
      :username,
      :email,
      :password,
      :password_confirmation,
      :admin
    )
  end
end
