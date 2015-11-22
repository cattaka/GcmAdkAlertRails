class CreateCommands < ActiveRecord::Migration
  def change
    create_table :commands do |t|
      t.string :actions_json
      t.string :exec_key
      t.belongs_to :device_group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
