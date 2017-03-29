class SiteMapController < ApplicationController
  layout nil
  def index
    headers['Content-Type'] = 'application/xml'
    respond_to do |format|
      format.xml do
        @projects = Project.all
        @people = Person.all
      end
    end
  end
end
