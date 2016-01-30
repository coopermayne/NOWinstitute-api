class MenuController < ApplicationController
  def index

    res = [
      {
      title: 'Morphosis',
      url: '',
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
      url: 'architecture',
      sorting: [ {
        title: 'Alphabetical',
        items: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
      }, {
        title: 'Year',
        items: [ '1970-1979', '1980-1989', '1990-1999', '2000-2009', '2010-2019' ]
      }, {
        title: 'Type',
        items: Project.all.select {|p| p.section && p.section.title=="Architecture"}.map {|p| p.project_types.first.title }.uniq
      }, {
        title: 'Location',
        items: []
      } ]
    }, 
    
    {
      title: 'Urban Design',
      url: 'urban-design'
    }, 
    
    {
      title: 'Tangents',
      url: 'tangents'
    }, {
      title: 'Research',
      url: 'research'
    }, {
      title: 'Media',
      url: 'media'
    }, {
      title: 'News',
      url: 'news'
    }]

    render json: res
  end

end
