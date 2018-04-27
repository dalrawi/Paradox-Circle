json.extract! concert, :id, :name, :start_time, :created_at, :updated_at
json.url concert_url(concert, format: :json)
