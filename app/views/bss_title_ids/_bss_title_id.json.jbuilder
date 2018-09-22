json.extract! bss_title_id, :id, :bss_title_id, :episode_id, :created_at, :updated_at
json.channels bss_title_id.channels.each do |channel|
  json.(channel, :id, :name, :code)
end
json.url bss_title_id_url(bss_title_id, format: :json)
