class AddIsPublishedToNewsAndPeople < ActiveRecord::Migration
  def change
    add_column :people, :is_published, :boolean, default: false
    add_column :news_items, :is_published, :boolean, default: false
  end
end
