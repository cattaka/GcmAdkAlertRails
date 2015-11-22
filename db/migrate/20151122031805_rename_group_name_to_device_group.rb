class RenameGroupNameToDeviceGroup < ActiveRecord::Migration
  def change
    rename_column :device_groups, :name, :name
  end
end
