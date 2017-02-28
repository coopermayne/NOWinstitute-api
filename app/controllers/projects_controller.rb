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
  def index
    @section = Section.find_by_title request.fullpath.slice(1,request.fullpath.length-1).capitalize
    @menu = build_response
    @menu_white = false
    @projects = Project.where(section_id: @section.id).includes(:primary_image, :project_types, :section, :components)
    #render html: Rails.cache.fetch("projects", :expires_in => 1.hours) { 
      #render_to_string :index 
    #}
  end

  def show
    @project = Project.includes(roles: [:position, :person ], uploads: [ :file_type, :credit ], bibliography_items: [:primary_image]).find(params[:id])
    #render html: Rails.cache.fetch("projects" + params[:id].to_s , :expires_in => 1.hours) { 
      #render_to_string :show 
    #}
  end

  def build_response
    all_slides = Slide.get_all_slides
    news = NewsItem.news_box_items     
    now_slides = all_slides["Now Institute"]
    home_slides = all_slides["Home Page"]

    res = {}
    now_section = Section.find_by_title("Now Institute")

    res[:homeSlides] = home_slides

    res[:sections] = [
      {
      title: 'Now',
      slides: now_slides,
      state: 'root.section-state',
      url: "about",
      contact: markdown( now_section.contact),
      about: markdown( now_section.about ), 
      sorting: [ {
        title: 'Contact',
        items: ''
      }, {
        title: 'People',
        items: ['Leadership']
      } ]
    },

    {
      title: 'Projects',
      url: "projects",
      state: 'root.section-state.sorting-state',
      sorting: [ {
        title: 'A-Z'
      }
      ]
    }, 

    {
      title: 'Research',
      url: "research",
      state: 'root.section-state.sorting-state',
      sorting: [ {
        title: 'A-Z'
      }
      ]
    }, 

    {
      title: 'News',
      url: 'news',
      state: 'root.section-state',
      items: news
    }
    ]

    res
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
