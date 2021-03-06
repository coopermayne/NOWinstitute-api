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

require 'test_helper'

class NewsItemsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
end
