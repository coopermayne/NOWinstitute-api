class MenuController < ApplicationController
  def links
  end

  def index
    types = Hash.new []

    news = NewsItem.order(created_at: :desc).limit(10).map do |item|
      img = item.primary_image ? item.primary_image.name : nil
      {id: item.id, title: item.title, image: img }
    end

    Project.includes(:project_types, :section).each do |p|
      next if !p.section
      types[p.section.title] =  (types[p.section.title] + p.project_types.map(&:title)).uniq
    end

    
    arch_slides = Section.includes(slides: [:image, :project]).find_by_title("Architecture").slides.map do |slide|
      {
        project_id: slide.project.id,
        project_title: slide.project.title,
        image: slide.image.name
      }
    end

    urban_slides = Section.includes(slides: [:image, :project]).find_by_title("Urban").slides.map do |slide|
      {
        project_id: slide.project.id,
        project_title: slide.project.title,
        image: slide.image.name
      }
    end
    tan_slides = Section.includes(slides: [:image, :project]).find_by_title("Tangents").slides.map do |slide|
      {
        project_id: slide.project.id,
        project_title: slide.project.title,
        image: slide.image.name
      }
    end
    morph_slides = Section.includes(slides: [:image, :project]).find_by_title("Morphosis").slides.map do |slide|
      {
        image: slide.image.name
      }
    end

    vid_slides = Slide.all.select{|s| s.mp4}.map do |s|
      {
        mp4: s.mp4.name,
        webm: s.webm.name,
        gif: s.gif.name,
        image: s.image.name
      }
    end

    res = {}
    res[:landing] = {
      slides: vid_slides
    }

    res[:sections] = [
      {
      title: 'Morphosis',
      slides: morph_slides,
      url: "about",
      sorting: [ {
        title: 'Awards',
        items: ''
      }, {
        title: 'People',
        items: ''
      }, {
        title: 'Media',
        items: ['Publications', 'Bibliography', 'Exhibitions', 'Video']
      } ]
    },

    {
      title: 'Architecture',
      slides: arch_slides,
      url: "architecture",
      sorting: [ {
        title: 'A-Z',
        items: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
      }, {
        title: 'Year',
        items: [ '1970-1979', '1980-1989', '1990-1999', '2000-2009', '2010-2019' ]
      }, {
        title: 'Type',
        items: types["Architecture"]
      }, {
        title: 'Location',
        items: []
      } ]
    }, 
    
    {
      title: 'Urban',
      slides: urban_slides,
      url: "urban",
      sorting: [ {
        title: 'A-Z',
        items: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
      }, {
        title: 'Year',
        items: [ '1970-1979', '1980-1989', '1990-1999', '2000-2009', '2010-2019' ]
      }, {
        title: 'Type',
        items: types["Urban"]
      }, {
        title: 'Location',
        items: []
      } ]
    }, 
    
    {
      title: 'Tangents',
      slides: tan_slides,
      url: "tangents",
      sorting: [ {
        title: 'A-Z',
        items: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
      }, {
        title: 'Year',
        items: [ '1970-1979', '1980-1989', '1990-1999', '2000-2009', '2010-2019' ]
      }, {
        title: 'Type',
        items: types["Tangents"]
      } ]
    }, {
      title: 'Research',
      slides: arch_slides,
      url: 'research',
      sorting: [{
          title: "Now Institute",
          items: types["Research"]
      }]
    }, {
      title: 'News',
      url: 'news',
      items: news
    }
    ]
    render json: res
  end


end


