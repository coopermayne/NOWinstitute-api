module FrontHelper

  def self.build_menu
    all_slides = Slide.get_all_slides
    now_slides = all_slides["Now Institute"]
    home_slides = all_slides["Home Page"]

    res = {}
    now_section = Section.find_by_title("Now Institute")

    res[:homeSlides] = home_slides

    res[:sections] = [
      {
      title: 'Now',
      slides: now_slides,
      url: "/about",
      contact: markdown( now_section.contact),
      about: markdown( now_section.about ),
    },

    {
      title: 'Projects',
      url: "/projects"
    }, 

    {
      title: 'Research',
      url: "/research"
    }, 

    {
      title: 'News',
      target: '_blank',
      url: 'http://www.aud.ucla.edu/programs/m_arch_ii_degree_1/studios/mayne/category/studio/news/'
    }
    ]

    res
  end

  def self.markdown(text)
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
