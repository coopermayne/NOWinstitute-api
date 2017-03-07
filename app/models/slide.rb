# == Schema Information
#
# Table name: slides
#
#  id              :integer          not null, primary key
#  rank            :integer
#  visible         :boolean
#  is_image        :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  section_id      :integer
#  image_upload_id :integer
#  project_id      :integer
#  title           :string
#

class Slide < ActiveRecord::Base
  include Clearcache

  belongs_to :section
  belongs_to :project

  has_many :uploads, as: :uploadable, dependent: :destroy

  belongs_to :image, class_name: 'Upload', foreign_key: :image_upload_id

  accepts_nested_attributes_for :image, :reject_if => proc { |att| att['id'].blank? && att['name'].blank? }

  #validations
  validates :section_id, presence: true
  #validates :image, presence: {message: "must be present"}

  #hooks
  before_save :set_uploads, :set_some_defaults



  #methods
  def is_on_home_page?
    self.section.title == "Home Page"
  end

  def video_slides_valid?
    self.image.name_url && ['jpg', 'jpeg', 'png'].include?(self.image.name.file.extension.downcase)
  end

  def self.get_all_slides
    all_slides = self.where(:visible => true).includes(:section, :project, :image).all.group_by(&:section)
    all_slides.keys.each { |k| all_slides[ k.title ] = all_slides.delete(k)}
    all_slides.each do |section, slide_array|
      has_title = !(["Home Page", "Morphosis"].include? section)
      slide_array.sort_by!{|sli| sli.rank || 9999 }
      slide_array.map! do |slide|
        {
          project_id: slide.project_id,
          rank: slide.rank,
          project_title: has_title ? slide.title : nil,
          image: slide.image && slide.image.name,
        }
      end
    end
    all_slides
  end


  private

  def set_uploads
    if self.image && !self.uploads.include?(self.image)
      self.uploads << self.image
    end
  end
  
  def set_some_defaults
    self.rank ||= 999
  end

  scope :with_section, -> (section_id) { where section_id: section_id }

end
