class AddSizeColumnsToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :height, :integer
    add_column :uploads, :width, :integer
  end
end
