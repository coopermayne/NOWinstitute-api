class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.string :name
      t.string :url

      t.timestamps null: false
    end
  end
end
