class AddRankColumnToProjectsAndPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :rank, :integer, default: 9999
    add_column :projects, :rank, :integer, default: 9999
  end

  def self.down
    remove_column :people, :rank, :integer, default: 9999
    remove_column :projects, :rank, :integer, default: 9999
  end
end
