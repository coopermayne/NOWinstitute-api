# == Schema Information
#
# Table name: news_items
#
#  id             :integer          not null, primary key
#  title          :string
#  description    :text
#  overview       :text
#  hit            :integer
#  place_name     :string
#  street_address :string
#  country        :string
#  city           :string
#  state          :string
#  zip            :integer
#  start_date     :date
#  end_date       :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  news_type_id   :integer
#  primary_id     :integer
#  in_news_box    :boolean          default(FALSE)
#  old_id         :integer
#  index_image_id :integer
#  address        :string
#  rank           :integer
#  link           :string
#  is_published   :boolean          default(FALSE)
#

class NewsItemsController < ApplicationController

  def index

    if params.keys.include? 'articles'
      @news_type = NewsType.find_by_title "Articles" 
    elsif params.keys.include? 'events'
      @news_type = NewsType.find_by_title "Events" 
    else
      @news_type = nil
    end


    if @news_type
      @news_items = NewsItem.all.select{|pr| pr.news_type ==  @news_type }
    else
      @news_items = NewsItem.all
    end

    @menu = FrontHelper.build_menu
  end

  def show
    @news_item = NewsItem.find(params[:id])
  end

end
