class Api::V1::TagsController < Api::V1::BaseController
  before_filter :check_unauthorized
  respond_to :json

  def index 
  	return render json: true
  end
  
end