class RemoveUnnecessaryColumnsPlease < ActiveRecord::Migration
  def self.up
    remove_column :slides, :vida_upload_id
    remove_column :slides, :vidb_upload_id
    remove_column :slides, :gif_upload_id
  end

  def self.down
    add_column :slides, :vida_upload_id, :integer
    add_column :slides, :vidb_upload_id, :integer
    add_column :slides, :gif_upload_id, :integer
  end
end

