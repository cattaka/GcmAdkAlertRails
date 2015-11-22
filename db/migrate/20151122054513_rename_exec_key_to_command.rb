class RenameExecKeyToCommand < ActiveRecord::Migration
  def change
    rename_column :commands, :exec_key, :name
  end
end
