# == Schema Information
#
# Table name: search_results
#
#  id              :integer          not null, primary key
#  content         :text
#  title           :string
#  searchable_id   :integer
#  searchable_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  weight          :integer          default(0)
#  thumb           :string
#  description     :string
#  uid             :string
#  section         :string
#  sorting_type    :string
#

class SearchResultsController < ApplicationController
  def index
    query = params[:q].gsub(/[^0-9a-z ]/i, '')
    @results = SearchResult.search(query)
  end
end
