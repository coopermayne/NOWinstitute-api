class FixPeopleColumns < ActiveRecord::Migration

  def self.up
    remove_column :people, :old_id
    remove_column :people, :hit
    remove_column :people, :is_morphosis
  end

  def self.down
    add_column :people, :old_id, :integer
    add_column :people, :hit, :integer
    add_column :people, :is_morphosis, :boolean
  end

end
