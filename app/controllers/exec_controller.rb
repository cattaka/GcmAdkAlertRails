class ExecController < ApplicationController
	def exec
		key = params[:key]
		cmd = params[:cmd]
		device_group = DeviceGroup.where(exec_key:key).first
		command = Command.where(device_group_id:device_group.id, name:cmd).first
		object = {}
		object['data'] = JSON.parse(command.actions_json)

		results = []
		uri = "https://gcm-http.googleapis.com"
		device_group.devices.each do |device|
			object['to'] = device.gcm_id
			client = Faraday::Connection.new(:url => uri)
			res = client.post do |req|
				req.url '/gcm/send'
				req.headers['Content-Type'] = 'application/json'
				req.headers['Authorization'] = 'key=' + Rails.application.secrets.gcm_server_api_key
				req.body = object.to_json
			end
			result = JSON.parse(res.body)
			if result['canonical_ids'] > 0 then
				device.gcm_id = result['results'][0]['registration_id']
				device.save
			end
			results.push(res.body)
		end

		render :json => results
	end
end
