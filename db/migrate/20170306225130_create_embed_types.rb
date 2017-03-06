class CreateEmbedTypes < ActiveRecord::Migration
  def change
    create_table :embed_types do |t|
      t.string :title
      t.string :uid
      t.text :instructions
      t.text :description

      t.timestamps null: false
    end
  end
end
