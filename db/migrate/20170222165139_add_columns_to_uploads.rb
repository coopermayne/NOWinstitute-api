class AddColumnsToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :content_type, :string
    add_column :uploads, :file_size, :string
  end
end
