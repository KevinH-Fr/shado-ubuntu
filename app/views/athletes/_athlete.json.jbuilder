json.extract! athlete, :id, :name, :discipline, :bio, :created_at, :updated_at
json.url athlete_url(athlete, format: :json)
