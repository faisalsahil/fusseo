class RoomsController < ApplicationController
  # before_action :authenticate_user!
  def show
    
  	# puts "0"*90
  	# puts session["session_id"]
   #  @messages = Message.all
   	respond_to do |format|
      format.html
      format.json { render json: "Hello world" }
    end
  end
end
