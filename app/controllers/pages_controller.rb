class PagesController < ApplicationController
  helper FrontHelper

  def main
    @menu_white = true
    @test = "test local var"
    @section = Section.find_by_title("Home Page") 
    @slides = Slide.with_section @section.id
    @menu = FrontHelper.build_menu
  end

  def about
    @menu_white = true
    @menu = FrontHelper.build_menu
    @section = Section.find_by_title("Now Institute") 
    @slides = Slide.with_section @section.id
  end

  def contact
    @menu = FrontHelper.build_menu
    @section = Section.find_by_title("Now Institute") 
  end
end
