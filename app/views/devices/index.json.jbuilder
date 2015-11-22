json.array!(@devices) do |device|
  json.extract! device, :id, :name, :gcm_id, :enabled, :device_group_id
  json.url device_url(device, format: :json)
end
