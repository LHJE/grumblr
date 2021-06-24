json.extract! post, :id, :content, :grass_tags, :only_followers, :user_id, :created_at, :updated_at
json.url post_url(post, format: :json)
