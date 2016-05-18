class User < ApplicationRecord
  after_commit :send_email
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :session
  has_many :followers
  has_many :posts
  has_many :accounts
def send_email

  UserMailer.registration_confirmation(email).deliver
end
end
