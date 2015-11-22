class ExecController < ApplicationController
	def exec
		key = params[:key]
		command = Command.where(exec_key:key).first
		object = {}
		object['data'] = JSON.parse(command.actions_json)

		results = []
		uri = "https://gcm-http.googleapis.com"
		command.device_group.devices.each do |device|
			object['to'] = device.gcm_id
			client = Faraday::Connection.new(:url => uri)
			res = client.post do |req|
				req.url '/gcm/send'
				req.headers['Content-Type'] = 'application/json'
				req.headers['Authorization'] = 'key=' + Rails.application.secrets.gcm_server_api_key
				req.body = object.to_json
			end
			puts res.body
			results.push(res.body)
		end

		render :json => results
	end
end
