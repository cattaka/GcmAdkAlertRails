class RenameGroupNameToDeviceGroup < ActiveRecord::Migration
  def change
    rename_column :device_groups, :group_name, :name
  end
end
