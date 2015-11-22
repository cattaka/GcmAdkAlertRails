json.array!(@device_groups) do |device_group|
  json.extract! device_group, :id, :group_name
  json.url device_group_url(device_group, format: :json)
end
