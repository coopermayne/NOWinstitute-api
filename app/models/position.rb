# == Schema Information
#
# Table name: positions
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rank       :integer
#  old_id     :integer
#

class Position < ActiveRecord::Base
  has_many :roles
end
