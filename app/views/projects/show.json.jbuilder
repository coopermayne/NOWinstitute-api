#json.(@project, :id, :title, :overview, :description, :program, :client, :size, :site_area, :lat)

json.result do |json|
  json.merge! @project.attributes
  json.types @project.project_types.map{|t| t.title }
  json.primary_image @project.primary_image

  #json.components @project.components, :id, :content, :rank, :component_type
  #
  json.galleries @project.getGalleries

  json.people @project.roles do |role|
    json.role_title role.position.title
    json.role_rank role.position.rank
    json.is_morphosis role.person.is_morphosis
    json.person role.person, :id, :name, :last_name, :is_morphosis, :is_collaborator, :is_consultant
  end

  json.awards @project.awards, :id, :title, :year
  json.bibliography_items @project.bibliography_items do |bib|
    json.merge! bib.attributes
    json.primary_image bib.primary_image
  end
end
