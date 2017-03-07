# == Schema Information
#
# Table name: people
#
#  id              :integer          not null, primary key
#  name            :string
#  last_name       :string
#  birthday        :date
#  description     :text
#  email           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  is_collaborator :boolean
#  is_consultant   :boolean
#  start_date      :date
#  end_date        :date
#  website         :string
#  location        :string
#  primary_id      :integer
#  index_image_id  :integer
#  is_leadership   :boolean          default(FALSE)
#  is_ucla_team    :boolean
#  is_published    :boolean          default(FALSE)
#

require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
end
