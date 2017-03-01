class PagesController < ApplicationController
  helper FrontHelper

  def main
    @display_mobile_menu = true
    @white_menu = true
    @section = Section.find_by_title("Home Page") 
    @slides = Slide.with_section @section.id
    @menu = FrontHelper.build_menu
  end

  def about
    @display_mobile_menu = true
    @white_menu = true
    @menu = FrontHelper.build_menu
    @section = Section.find_by_title("Now Institute") 
    @slides = Slide.with_section @section.id
  end

  def contact
    @no_menu = true
    @menu = FrontHelper.build_menu
    @section = Section.find_by_title("Now Institute") 
  end
end
