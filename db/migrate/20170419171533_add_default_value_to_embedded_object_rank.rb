class AddDefaultValueToEmbeddedObjectRank < ActiveRecord::Migration
  def change
    change_column :embedded_objects, :rank, :integer, :default => 0
  end
end
