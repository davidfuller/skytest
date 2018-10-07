json.extract! clip, :id, :name, :note, :filename, :folder_id, :has_audio, :audio_filename, :clip_type_id, :duration, :start_season, :start_episode, :end_season, :end_episode, :season_generic, :totally_generic, :first_use, :last_use, :completion, :user_id, :status_id, :created_at, :updated_at
json.url clip_url(clip, format: :json)
