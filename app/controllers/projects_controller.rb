# == Schema Information
#
# Table name: projects
#
#  id             :integer          not null, primary key
#  title          :string
#  overview       :text
#  description    :text
#  program        :text
#  client         :string
#  size           :integer
#  site_area      :decimal(, )
#  lat            :decimal(, )
#  lon            :decimal(, )
#  street_address :string
#  zip            :integer
#  design_sdate   :date
#  design_edate   :date
#  constr_sdate   :date
#  constr_edate   :date
#  open_date      :date
#  close_date     :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  section_id     :integer
#  height         :integer
#  hit            :integer
#  city           :string
#  state          :string
#  country        :string
#  primary_id     :integer

class ProjectsController < ApplicationController
  helper FrontHelper

  def index
    @section = Section.find_by_title request.fullpath.slice(1,request.fullpath.length-1).capitalize
    render html: Rails.cache.fetch(@section.title.downcase, :expires_in => 1.hours) { 
      @menu = FrontHelper.build_menu
      @menu_white = false
      @projects = Project.where(section_id: @section.id).includes(:primary_image, :project_types, :section, :components)
      render_to_string :index 
    }
  end

  def show
    @ref = request.referer
    render html: Rails.cache.fetch("projects#{@ref}" + params[:id].to_s , :expires_in => 1.hours) { 
      @no_menu = true
      @project = Project.includes(roles: [:position, :person ], uploads: [ :file_type, :credit ], bibliography_items: [:primary_image]).find(params[:id])
      render_to_string :show 
    }
  end

  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end


end
