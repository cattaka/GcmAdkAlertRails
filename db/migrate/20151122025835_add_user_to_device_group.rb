class AddUserToDeviceGroup < ActiveRecord::Migration
  def change
    add_reference :device_groups, :user, index: true, foreign_key: true
  end
end
