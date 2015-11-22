class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      change_column :device_groups, :user_id, :user, null: false
      change_column :devices, :device_group_id, :device_group, null: false
    end
  end
end
