# == Schema Information
#
# Table name: projects
#
#  id             :integer          not null, primary key
#  title          :string
#  overview       :text
#  description    :text
#  lat            :decimal(, )
#  lon            :decimal(, )
#  street_address :string
#  zip            :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  section_id     :integer
#  city           :string
#  state          :string
#  country        :string
#  primary_id     :integer
#  index_image_id :integer
#  address        :string
#  date           :date
#  start          :date
#  end            :date
#  is_published   :boolean          default(FALSE)
#

class Project < ActiveRecord::Base
  include Searchable
  include Primaryable
  #include Publishable
  include Clearcache

  has_many :components
  has_many :embedded_objects
  has_many :roles, dependent: :destroy

  belongs_to :section
  has_and_belongs_to_many :project_types, join_table: "projects_project_types"
  has_and_belongs_to_many :awards
  has_and_belongs_to_many :bibliography_items

  accepts_nested_attributes_for :roles, allow_destroy: true
  accepts_nested_attributes_for :awards, allow_destroy: true
  accepts_nested_attributes_for :bibliography_items, allow_destroy: true
  accepts_nested_attributes_for :components, allow_destroy: true
  accepts_nested_attributes_for :embedded_objects, allow_destroy: true

  scope :with_section, -> (section_id) { where section_id: section_id }

  def para_title
    title.gsub('.','').parameterize
  end
end
