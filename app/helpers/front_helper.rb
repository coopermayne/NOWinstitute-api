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
      url: "/about",
      title: 'Now',
      slides: now_slides,
      contact: now_section.contact,
      about: now_section.about,
      sorting: [
        {
          url: "/about",
          title: "About",
          items: ""
        },
        {
          url: "/about/people",
          title: "People",
          items: [
            "Leadership"
          ]
        },
        {
          url: "/about/contact",
          title: "Contact",
          items: ""
        }
      ]
    },

    {
      title: 'Projects',
      url: "/projects",
      sorting: [
        {
          title: 'Research',
          url: "/projects?research"
        },
        {
          title: 'Global Issues',
          url: "/projects?global"
        }
      ]
    }, 

    {
      title: 'Publications',
      url: "/research",
      sorting: [
        #{
          #title: "Location",
          #items: [ ]
        #}
      ]
    }, 

    {
      title: 'News',
      target: '_blank',
			url: 'http://www.aud.ucla.edu/programs/m_arch_ii_degree_1/studios/mayne/category/events/',
			sorting: []
      #url: '/news',
      #sorting: [
        #{
          #title: 'Articles',
          #url: "/news?articles"
        #},
        #{
          #title: 'Events',
          #url: "/news?events"
        #}
      #]
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
