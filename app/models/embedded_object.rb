# == Schema Information
#
# Table name: embedded_objects
#
#  id            :integer          not null, primary key
#  title         :string
#  url           :string
#  uid           :string
#  obj_type      :string
#  rank          :integer
#  project_id    :integer
#  person_id     :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  embed_type_id :integer
#

class EmbeddedObject < ActiveRecord::Base
  belongs_to :project
  belongs_to :person
  belongs_to :embed_type
end
