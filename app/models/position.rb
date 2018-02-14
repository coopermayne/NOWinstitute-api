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
  before_save :fix_rank

  def fix_rank
    if self.rank.nil?
      self.rank = 99999
    end
  end
end
