class EmbeddedObject < ActiveRecord::Base
  belongs_to :project
  belongs_to :person
  belongs_to :embed_type
end
