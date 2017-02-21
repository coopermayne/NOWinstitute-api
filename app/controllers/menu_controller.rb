class MenuController < ApplicationController
  def links
  end

  def index
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
      url: "projects",
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
      items: news
    }
    ]
    render json: res
  end

	def videos
    vid_slides = Section.find_by_title("Home Page").get_slides
		render json: vid_slides
	end

end


