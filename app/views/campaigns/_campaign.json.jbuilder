json.extract! campaign, :id, :title, :description, :periodicity, :subscription, :target, :start, :end, :athlete_id, :created_at, :updated_at
json.url campaign_url(campaign, format: :json)
