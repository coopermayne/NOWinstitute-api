class PagesController < ApplicationController
  helper FrontHelper

  def main
    #render html: Rails.cache.fetch("main", :expires_in => 1.hours) { 
      @display_mobile_menu = true
      @white_menu = true
      @section = Section.find_by_title("Home Page") 
      @slides = Slide.with_section @section.id
      @menu = FrontHelper.build_menu
      #render_to_string :main
    #}
  end

  def about
    #render html: Rails.cache.fetch("about", :expires_in => 1.hours) { 
      @display_mobile_menu = true
      @white_menu = true
      @menu = FrontHelper.build_menu
      @section = Section.find_by_title("Now Institute") 
      @slides = Slide.with_section @section.id
      #render_to_string :about
    #}
  end

  def contact
    #render html: Rails.cache.fetch("contact", :expires_in => 1.hours) { 
      @no_menu = true
      @menu = FrontHelper.build_menu
      @section = Section.find_by_title("Now Institute") 
      #render_to_string :contact
    #}
  end
end
