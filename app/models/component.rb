# == Schema Information
#
# Table name: components
#
#  id                :integer          not null, primary key
#  content           :text
#  rank              :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  project_id        :integer
#  component_type_id :integer
#  old_id            :integer
#  title             :string
#  is_visible        :boolean          default(FALSE)
#

class Component < ActiveRecord::Base

  belongs_to :project

  belongs_to :component_type
  
end
