# == Schema Information
#
# Table name: journalists
#
#  id          :integer          not null, primary key
#  email       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  first_name  :string
#  last_name   :string
#  affiliation :string
#

class Journalist < ActiveRecord::Base
  def self.to_csv
    attributes = %w{email, first_name, last_name, affiliation}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |journalist|
        csv << attributes.map{ |attr| journalist.send(attr) }
      end
    end
  end
end
