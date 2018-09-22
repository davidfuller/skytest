json.extract! channel, :id, :name, :code, :channel_type_id, :created_at, :updated_at
json.url channel_url(channel, format: :json)
json.channel_type channel.channel_type.name
