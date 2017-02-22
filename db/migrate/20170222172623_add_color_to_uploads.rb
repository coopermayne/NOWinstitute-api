class AddColorToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :color, :string
  end
end
