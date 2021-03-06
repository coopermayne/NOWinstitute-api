module Clearcache
  # using this module... Project, Award, BibliographyItem, Person, NewsItem
  
  extend ActiveSupport::Concern

  included do
    after_save :clear_all_cache
    after_destroy :clear_all_cache
  end

  def clear_all_cache
    Rails.cache.clear
  end

end
