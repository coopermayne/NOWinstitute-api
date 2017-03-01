class AddSlugColumnToPeopleAndProjects < ActiveRecord::Migration
  def change
    add_column :people, :slug, :string
    add_column :projects, :slug, :string
  end
end
