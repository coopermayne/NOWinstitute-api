class AddEmbedTypeReferenceToEmbeddedObjectsTable < ActiveRecord::Migration
  def change
    add_reference :embedded_objects, :embed_type, index: true
  end
end
