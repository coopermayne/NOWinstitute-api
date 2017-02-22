module Publishable
  # using this module... Project, Award, BibliographyItem, Person, NewsItem

  extend ActiveSupport::Concern

  included do
    validate :ready_to_publish
  end

  def ready_to_publish
    return if !is_published #no validations if it is not being published

    validates_presence_of  :primary_image, :index_image, :message => "is required before publishing"

    if is_a? Project
      validates_presence_of  :title, :section, :message => "is required before publishing"
    elsif is_a? Person
      validates_presence_of  :name, :message => "is required before publishing"
    elsif is_a? NewsItem
      validates_presence_of  :title, :section, :message => "is required before publishing"
    end

    unless self.errors.messages.empty?
      self.is_published = false 
    end

  end
end
