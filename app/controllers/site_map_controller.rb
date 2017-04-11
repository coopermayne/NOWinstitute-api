class SiteMapController < ApplicationController
  layout nil
  def index
    headers['Content-Type'] = 'application/xml'
    respond_to do |format|
      format.xml do
        @projects = Project.all.select{|pr| !pr.section.nil?}
        @people = Person.all.select{|per| !per.name.nil?}
      end
    end
  end
end
