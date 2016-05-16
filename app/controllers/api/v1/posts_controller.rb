class Api::V1::PostsController < Api::V1::BaseController
  # before_action :authenticate_user!
  # before_action :authenticate_api_v1_user!
   # acts_as_token_authentication_handler_for User, fallback_to_devise: false
  before_filter :check_unauthorized
  respond_to :json

  def index 
    @posts = current_user.posts
    respond_with @posts
  	# return render json: true
  end

  def create
    
  end
 
end