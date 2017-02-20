class RemoveIsEmployedFromPeople < ActiveRecord::Migration
  def self.up
    remove_column :people, :is_employed
  end
  def self.down
    add_column :people, :is_employed, :boolean
  end
end
