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
#  is_morphosis    :boolean
#  is_employed     :boolean
#  is_collaborator :boolean
#  is_consultant   :boolean
#  start_date      :date
#  end_date        :date
#  website         :string
#  hit             :integer
#  location        :string
#  primary_id      :integer
#

class PeopleController < ApplicationController
  def index
    @menu = FrontHelper.build_menu
    @section = Section.find_by_title("Now Institute") 
    @people = Person.includes(:primary_image).where(is_ucla_team: true)
  end

  def show
    @no_menu = true
    @menu = FrontHelper.build_menu
    @section = Section.find_by_title("Now Institute") 
    @person = Person.includes(:educations, roles: [:position, :project]).find(params[:id])
  end
end
