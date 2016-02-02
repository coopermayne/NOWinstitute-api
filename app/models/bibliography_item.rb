# == Schema Information
#
# Table name: bibliography_items
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  overview     :text
#  hit          :integer
#  author       :string
#  article_name :string
#  book_title   :string
#  subtitle     :string
#  publication  :string
#  publisher    :string
#  date         :string
#  pub_date     :date
#  pages        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  primary_id   :integer
#

class BibliographyItem < ActiveRecord::Base
  has_and_belongs_to_many :projects

  has_many :uploads, as: :uploadable
  belongs_to :primary_image, class_name: 'Upload', foreign_key: :primary_id
end
