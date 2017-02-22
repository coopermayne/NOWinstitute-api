class AddPublishedColumnToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :is_published, :boolean, default: false
  end
end
