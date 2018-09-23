json.extract! message, :id, :text, :read_at, :created_at, :updated_at
json.url message_url(message, format: :json)
