class CreateEmbeddedObjects < ActiveRecord::Migration
  def change
    create_table :embedded_objects do |t|
      t.string :title
      t.string :url
      t.string :uid
      t.string :type
      t.integer :rank
      t.references :project, index: true, foreign_key: true
      t.references :person, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
