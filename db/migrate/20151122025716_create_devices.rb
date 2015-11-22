class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :name
      t.string :gcm_id
      t.boolean :enabled
      t.references :device_group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
