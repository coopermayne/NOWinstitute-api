class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :name
      t.boolean :copyright
      t.integer :rank

      t.timestamps null: false
    end
  end
end
