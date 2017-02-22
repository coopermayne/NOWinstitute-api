class AddDateColumnsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :start, :date
    add_column :projects, :end, :date
  end
end
