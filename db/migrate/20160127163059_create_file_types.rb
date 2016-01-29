class CreateFileTypes < ActiveRecord::Migration
  def change
    create_table :file_types do |t|
      t.string :title
      t.string :slug
      t.integer :rank

      t.timestamps null: false
    end
  end
end
