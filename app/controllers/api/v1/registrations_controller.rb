class Api::V1::RegistrationsController < DeviseController
  prepend_before_filter :require_no_authentication, only: [:new, :create, :cancel]
  prepend_before_filter :authenticate_scope!, only: [:edit, :update, :destroy]
  respond_to :json


  # POST /resource
  def create
    require 'securerandom'
    build_resource(sign_up_params)
    if resource.save
      sign_up(resource_name, resource)
      token = SecureRandom.hex(16)
      user_session = resource.build_session
      user_session.email = resource.email
      user_session.token = token
      user_session.save!
      # token = resource.authentication_token
      render json: {authentication_token: token, email: resource.email}
    else
      invalid_signup_attempt(resource.errors)
    end
  end


  # DELETE /resource
  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_flashing_format?
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  protected
  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  def build_resource(hash=nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
  end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  def invalid_signup_attempt(error)
    warden.custom_failure!
    render :json=> {:success=>false, :message=>error}, :status=>422
  end

  def sign_up_params
    # devise_parameter_sanitizer.sanitize(:sign_up)
    params.require(:user).permit(:username,:email, :password, :password_confirmation)
  end
end
