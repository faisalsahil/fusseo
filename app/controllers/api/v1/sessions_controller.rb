class Api::V1::SessionsController < DeviseController
  # prepend_before_filter :require_no_authentication, :only => [:create ]
  # acts_as_token_authentication_handler_for User
  respond_to :json
  
  def create
    require 'securerandom'
    user = User.find_by_email(params[:user][:email])
    token = nil
    if user && user.valid_password?(params[:user][:password])
      # token = user.authentication_token
      sign_in(:user, user)
      # token = (0...32).map { ('a'..'z').to_a[rand(26)] }.join
      token = SecureRandom.hex(16)
      user_session = user.session || user.build_session
      user_session.email = user.email
      user_session.token = token
      user_session.save!

      render json: {status: 200, authentication_token: token, email: user.email}
    else
      invalid_login_attempt
    end
  end

  
  def destroy
    user_session = current_user.session
    if user_session.destroy
      return render json: {status: 200, message: "You're successfully logout."}
    else
      return render json: {status: 401, message: "Something went wrong."}  
    end
  end

  protected
  
  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:message=>"Error with your login or password", :status=>401}
  end
end