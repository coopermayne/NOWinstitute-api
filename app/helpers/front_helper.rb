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
      contact: markdown( now_section.contact),
      about: markdown( now_section.about ),
      sorting: [
        {
          url: "/about/contact",
          title: "Contact",
          items: ""
        },
        {
          url: "/about/people",
          title: "People",
          items: [
            "Leadership"
          ]
        }
      ]
    },

    {
      title: 'Projects',
      url: "/projects",
      sorting: [
        {
          title: "A-Z",
          items: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        },
        {
          title: "Year",
          items: [
            "2010-2019",
            "2000-2009",
            "1990-1999",
            "1980-1989",
            "1970-1979"
          ]
        },
        {
          title: "Location",
          items: [ ]
        }
      ]
    }, 

    {
      title: 'Research',
      url: "/research",
      sorting: [
        {
          title: "A-Z",
          items: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        },
        {
          title: "Year",
          items: [
            "2010-2019",
            "2000-2009",
            "1990-1999",
            "1980-1989",
            "1970-1979"
          ]
        },
        {
          title: "Location",
          items: [ ]
        }
      ]
    }, 

    {
      title: 'News',
      sorting: [],
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
