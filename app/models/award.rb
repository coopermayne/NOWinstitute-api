# == Schema Information
#
# Table name: awards
#
#  id             :integer          not null, primary key
#  title          :string
#  description    :text
#  overview       :text
#  hit            :integer
#  year           :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  primary_id     :integer
#  old_id         :integer
#  index_image_id :integer
#

class Award < ActiveRecord::Base
  include Searchable
  include Primaryable

  has_and_belongs_to_many :projects

  validates_presence_of :title
end
