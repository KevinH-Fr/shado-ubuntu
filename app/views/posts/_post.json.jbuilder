json.extract! post, :id, :title, :location, :content, :athlete_id, :created_at, :updated_at
json.url post_url(post, format: :json)
