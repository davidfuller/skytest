json.extract! channel, :id, :name, :code, :channel_type_id, :created_at, :updated_at
json.channel_type channel.channel_type.name
json.url channel_url(channel, format: :json)
