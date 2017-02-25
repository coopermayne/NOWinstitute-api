json.array! @people do |person|
  json.(person, :id, :name, :last_name, :description, :is_leadership)
  json.image person.index_image && person.index_image.name
end
