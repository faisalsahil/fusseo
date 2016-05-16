class Post < ApplicationRecord

	belongs_to :user
	has_many :tags
	has_many :comments
	has_many :likes
	after_create :broad_cast

	def broad_cast
		BroadcastMessageJob.perform_later self
	end
end
