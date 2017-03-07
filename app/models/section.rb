# == Schema Information
#
# Table name: sections
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rank       :integer
#  content    :text
#  old_id     :integer
#  about      :text
#  contact    :text
#  employment :text
#  media      :text
#

class Section < ActiveRecord::Base
  include Clearcache

  has_many :projects
  has_many :slides
  has_many :project_types

  accepts_nested_attributes_for :project_types

  def get_slides

    self.slides.select(&:visible).sort_by(&:rank).map do |slide|
      {
        project_id: slide.project_id,
        rank: slide.rank,
        project_title:  slide.title,
        image: slide.image && slide.image.name,
      }
    end
  end

  def get_types

    project_types.select{|pt| pt.ancestry.nil?}.sort_by{|pt| pt.rank}.map do |pt|
      {
        title: pt.title,
        children: pt.children.sort_by{|ch| ch.rank}.map{|ch| { title: ch.title } }
      }
    end
  end
end
