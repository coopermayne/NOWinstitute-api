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

class PeopleController < ApplicationController
  def index
    render html: Rails.cache.fetch('people', :expires_in => 30.days) { 
    @section = Section.find_by_title("Now Institute") 
    @menu = FrontHelper.build_menu
    @people = Person.order(:last_name).includes(:primary_image).where(is_ucla_team: true)
    render_to_string :index 
    }
  end

  def show
    @ref = request.referer
    render html: Rails.cache.fetch("people#{@ref}" + params[:id].to_s , :expires_in => 30.days) { 
    @no_menu = true
    @menu = FrontHelper.build_menu
    @section = Section.find_by_title("Now Institute") 
    @person = Person.includes(:educations, roles: [:position, :project]).find(params[:id])
    render_to_string :show
    }
  end
end
