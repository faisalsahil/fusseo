class Api::V1::BaseController < ActionController::Base
  respond_to :json
  # acts_as_token_authentication_handler_for User

  acts_as_token_authentication_handler_for User, fallback: :none,
    unless: lambda { |controller| @skip_token_auth }

  append_view_path "#{Rails.root}/app/views"

  def check_unauthorized
    user_session = Session.where(token: params[:user][:authentication_token], email: params[:user][:email]).try(:first)
  	if !user_session
	  	return render json: {status: 401, message: "Unthorized. "}
	  else
      current_user = user_session.user
    end
  end


  def skip_token_auth
    Rails.logger.debug "setting skip token auth for #{params[:controller]}##{params[:action]}"
    @skip_token_auth = true
  end
end