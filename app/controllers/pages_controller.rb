class PagesController < ApplicationController
  helper FrontHelper

  def main
    @test = "test local var"
    @section = Section.find_by_title("Home Page") 
    @slides = Slide.with_section @section.id
    @menu = FrontHelper.build_menu
    @menu_white = true
  end

  def about
    @menu = FrontHelper.build_menu
    @section = Section.find_by_title("Now Institute") 
    @slides = Slide.with_section @section.id
  end
end
