class MenuController < ApplicationController
  def index

    loc = 'menu-cache-location1'
    in_cache = Rails.cache.read(loc)

    if in_cache
      res = in_cache
      message = "hit"
    else
      res = build_response
      message = "miss"

      Rails.cache.write(loc, res)
    end

    render :json => res
    
  end

  def build_response
    all_slides = Slide.get_all_slides
    news = NewsItem.news_box_items     
    now_slides = all_slides["Now Institute"]
    home_slides = all_slides["Home Page"]

    res = {}
    now_section = Section.find_by_title("Now Institute")
    res[:sections] = [
      {
      title: 'Now',
      slides: now_slides,
      state: 'root.section-state',
      url: "about",
      contact: now_section.contact,
      about: now_section.about,
      sorting: [ {
        title: 'Contact',
        items: ''
      }, {
        title: 'People',
        items: ['Leadership']
      }, {
        title: 'Media',
        items: ['Books', 'Bibliography', 'Awards']
        #items: ['Books', 'Bibliography', 'Videos', 'Awards', 'Exhibitions']
      } ]
    },

    {
      title: 'Projects',
      url: "projects",
      state: 'root.section-state.sorting-state',
      sorting: [ {
        title: 'A-Z',
        items: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
      }, {
        title: 'Year',
        items: [ '1970-1979', '1980-1989', '1990-1999', '2000-2009', '2010-2019' ].reverse
      }, {
        title: 'Type',
        items: Section.find_by_title("Projects").get_types
      } ]
    }, 

    {
      title: 'Research',
      url: "research",
      state: 'root.section-state.sorting-state',
      sorting: [ {
        title: 'A-Z',
        items: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
      }, {
        title: 'Year',
        items: [ '1970-1979', '1980-1989', '1990-1999', '2000-2009', '2010-2019' ].reverse
      }, {
        title: 'Type',
        items: Section.find_by_title("Research").get_types
      } ]
    }, 

    {
      title: 'News',
      url: 'news',
      state: 'root.section-state',
      items: news
    }
    ]
  end

	def videos
    vid_slides = Section.find_by_title("Home Page").get_slides
		render json: vid_slides
	end

end


