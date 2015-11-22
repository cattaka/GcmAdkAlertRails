class DeviceGroup < ActiveRecord::Base
	belongs_to :user
	has_many :device
end
