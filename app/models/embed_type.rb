# == Schema Information
#
# Table name: embed_types
#
#  id           :integer          not null, primary key
#  title        :string
#  uid          :string
#  instructions :text
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class EmbedType < ActiveRecord::Base
  has_many :embedded_objects
end
