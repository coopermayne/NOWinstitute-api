json.merge! @person.attributes 
json.primary_image @person.primary_image

json.description markdown( @person.description )

json.educations @person.educations do |education|
  json.title education.title
end

json.roles_sorted @person.getRoles do |pos, roles|
  json.position_title pos
  json.roles roles.reverse do |role|
    json.id role.project_id
    json.title role.project.title
    json.section role.project.section.title
  end
end

json.roles @person.roles do |role|
  json.title role.position.title
  json.rank role.position.rank
  json.project do |json|
    json.id role.project.id
    json.title role.project.title
    json.section role.project.section.title
  end
end
