class RemoveUnnecessaryColumns < ActiveRecord::Migration
  def self.up
    remove_column :projects, :sustainability
    remove_column :projects, :program
    remove_column :projects, :client
    remove_column :projects, :size
    remove_column :projects, :site_area
    remove_column :projects, :design_sdate
    remove_column :projects, :design_edate
    remove_column :projects, :constr_sdate
    remove_column :projects, :constr_edate
    remove_column :projects, :open_date
    remove_column :projects, :close_date
    remove_column :projects, :height
    remove_column :projects, :hit
    remove_column :projects, :old_id
  end

  def self.down
    add_column :projects, :sustainability, :text
    add_column :projects, :program, :text
    add_column :projects, :client, :string
    add_column :projects, :size, :integer
    add_column :projects, :site_area, :decimal
    add_column :projects, :design_sdate, :date
    add_column :projects, :design_edate, :date
    add_column :projects, :constr_sdate, :date
    add_column :projects, :constr_edate, :date
    add_column :projects, :open_date, :date
    add_column :projects, :close_date, :date
    add_column :projects, :height, :integer
    add_column :projects, :hit, :integer
    add_column :projects, :old_id, :integer
  end
end


