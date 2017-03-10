class RemoveSlugFromProjectsAndPeople < ActiveRecord::Migration
  def change
    remove_column :people, :slug, :string
    remove_column :projects, :slug, :string
  end
end
