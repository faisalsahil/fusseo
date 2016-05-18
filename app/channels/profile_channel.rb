# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ProfileChannel < ApplicationCable::Channel
  def subscribed
    # user = User.find_by_email(params[:email])
    # token = nil
    token = current_user
    # if user
    #   user_session = user.session || user.build_session
    #   user_session.email = user.email
    #   user_session.token = token
    #   user_session.save!
    # else
      follow(0)
      sign_up_broadcast(token)
    # end  
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def follow(data)
    # token = SecureRandom.hex(16)
    stream_from "profile_channel_#{current_user}"
  end

  def unfollow
    stop_all_streams 
    #Session Destroy   Do It
  end


  def sign_in(data)
    user = User.find_by_email(data["email"])
    if user && user.valid_password?(data["password"])
      user_session = user.session || user.build_session
      user_session.email = user.email
      user_session.token = data["token"]
      user_session.save!
      ActionCable.server.broadcast "profile_channel_#{current_user}", user_session
    end
  end

  def sign_up_broadcast(data)
    ActionCable.server.broadcast "profile_channel_#{current_user}", data
    
  end

  def sign_up(data)
    puts "sign_up"*90
    puts data
    puts "end"*90
    email = data["email"]
    password = data["password"]
    token = data["token"]
    user = User.new
    user.email = email
    user.password = password
    user.save!
    message = {
      "message" => "You signed up sucesfully."
    }

    ActionCable.server.broadcast "profile_channel_#{current_user}", message
    # Save data into DbB and then broadcast success message to data['token']
  end

  def sign_out
  end

  def edit(data)
    puts 'edit'*90
    puts data
    puts 
    puts "=="*90
    user_session = Session.where(email: data['email']).try(:first)
    user = "Unauthorized!"
    if user_session
      user = user_session.user
      posts = user.posts
    end
    # BroadcastMessageJob.perform_later "profile_channel_#{user_session.token}", user 
     ActionCable.server.broadcast "profile_channel_#{user_session.token}", posts
  end

end
