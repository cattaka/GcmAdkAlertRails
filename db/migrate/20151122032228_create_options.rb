class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      change_column :device_groups, :user_id, :integer, null: false
      change_column :devices, :device_group_id, :integer, null: false
    end
  end
end
