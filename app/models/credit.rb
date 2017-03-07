# == Schema Information
#
# Table name: credits
#
#  id         :integer          not null, primary key
#  name       :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  old_id     :integer
#

class Credit < ActiveRecord::Base
  has_many :uploads
end
