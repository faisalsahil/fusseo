class UserMailer < ApplicationMailer
  default :from => 'fusseo@gmail.com'
  def registration_confirmation(email)
    @email = email
    @token = User.find_by_email(email).authentication_token
    @base_url = 'http://localhost:3000'

    mail(:to => email, :subject => "Confirmation Email")
  end
end
