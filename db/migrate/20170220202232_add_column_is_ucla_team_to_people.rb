class AddColumnIsUclaTeamToPeople < ActiveRecord::Migration
  def change
    add_column :people, :is_ucla_team, :boolean
  end
end
