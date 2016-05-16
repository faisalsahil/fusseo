class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def getAuthToken
    var token = Devise.friendly_token
  end

  def update
    email = params[:user_email]
    password = params[:user_token]
    name = params[:user_name]

    user = User.find_by_email(email)

    # if user.valid_password?(password)
    user.name = name
    user.email = email
    user.save
    return render :json=> {status: 200, email: email, name: name}
    # end
  end
end