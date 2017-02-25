class ChangeColumnName < ActiveRecord::Migration
  def self.up
    rename_column :embedded_objects, :type, :obj_type
  end

  def self.down
    rename_column :embedded_objects, :obj_type, :type
  end
end
