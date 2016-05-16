# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "room_channel"
  	# puts "00"*90
  	puts current_user.inspect
    # return current_user
  end

  def follow(data)
  	stream_from "room_channel_#{data['message_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
   message = Message.create content: data['message'], user: current_user
    return message
  end

  def create_post(data)
  	Post.create!(title: data.title, latitude: data.latitude)
  end
end
