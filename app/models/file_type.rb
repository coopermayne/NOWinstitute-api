# == Schema Information
#
# Table name: file_types
#
#  id         :integer          not null, primary key
#  title      :string
#  slug       :string
#  rank       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  old_id     :integer
#

class FileType < ActiveRecord::Base
  has_many :uploads
  validates_presence_of :rank, :title
end
