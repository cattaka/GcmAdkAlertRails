class AddExecKeyToDeviceGroup < ActiveRecord::Migration
  def change
    add_column :device_groups, :exec_key, :string
  end
end
