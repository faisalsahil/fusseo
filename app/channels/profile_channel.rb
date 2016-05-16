# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ProfileChannel < ApplicationCable::Channel
  def subscribed
    user = User.find_by_email(params[:email])
    # token = nil
    if user && user.valid_password?(params[:password])
      token = current_user
      user_session = user.session || user.build_session
      user_session.email = user.email
      user_session.token = token
      user_session.save!
      follow(0)
      sign_in(user_session)
    end  
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
    ActionCable.server.broadcast "profile_channel_#{current_user}", data
  end

  def sign_up
  end

  def sign_out
  end

  def edit(data)
    user_session = Session.where(email: data['email']).try(:first)
    user = "Unauthorized!"
    if user_session
      user = user_session.user
    end
    BroadcastMessageJob.perform_later "profile_channel_#{user_session.token}", user 
  end

end
