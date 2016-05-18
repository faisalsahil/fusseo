class BroadcastMessageJob < ApplicationJob
  queue_as :default

  def perform(channel_stream,data)
  	puts "mm"*90
  	puts channel
  	puts data
    user = data
    post = user.posts
  	id = 12345
    ActionCable.server.broadcast channel_stream, data
  end

  private
  def render_message(message)
    ApplicationController.renderer.render message
  end
end
