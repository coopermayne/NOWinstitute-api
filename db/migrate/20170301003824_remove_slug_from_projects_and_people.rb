class RemoveSlugFromProjectsAndPeople < ActiveRecord::Migration
  def change
    remove_column :people, :slug
    remove_column :projects, :slug
  end
end
