module ApplicationHelper

  def slugify(input)
    if input.is_a? NewsItem
      return "/news/#{input.id}-#{input.para_name}"
    elsif input.is_a? Person
      return "/about/people/#{input.id}-#{input.para_name}"
    else
      return "/#{input.section.title.downcase}/#{input.id}-#{input.para_title}"
    end
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render("admin/shared/" + association.to_s.singularize + "_fields", f: builder)
    end
    link_to(fa_icon("plus", text: name.html_safe), '#', class: "add_fields btn btn-primary", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def recent_years
    {start_year: Date.today.year - 90, end_year: Date.today.year}
  end

  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

end
