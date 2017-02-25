class MenuController < ApplicationController
  def index
    render :json => Rails.cache.fetch("menu-json", :expires_in => 3.hours) { build_response }
  end

  def build_response
    vid_slides = Section.find_by_title("Home Page").get_slides

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
      }, {
        title: 'Year'
      },
      {
        title: 'Type',
        items: Section.find_by_title("Projects").get_types
      }
      ]
    }, 

    {
      title: 'Research',
      url: "research",
      state: 'root.section-state.sorting-state',
      sorting: [ {
        title: 'A-Z'
      }, {
        title: 'Year'
      },
      {
        title: 'Type',
        items: Section.find_by_title("Research").get_types
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


