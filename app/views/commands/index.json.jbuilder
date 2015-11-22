json.array!(@commands) do |command|
  json.extract! command, :id, :actions_json, :exec_key, :device_group_id
  json.url command_url(command, format: :json)
end
