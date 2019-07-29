json.extract! listing, :id, :spark_id, :listing_api_url, :created_at, :updated_at
json.url listing_url(listing, format: :json)
