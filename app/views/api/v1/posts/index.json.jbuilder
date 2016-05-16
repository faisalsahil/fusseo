json.array!(@posts) do |post|
  json.extract! post, :id, :title, :latitude, :longitude, :location
  json.tags  post.tags do |tag|
		json.tag_name tag.tag_name
	end

	json.comments  post.comments.includes(:user) do |comment|
		json.commented_by comment.user.email
		json.content  comment.content
		json.commented_at comment.created_at
	end

end