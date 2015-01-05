json.array!(@course_groups) do |course_group|
  json.extract! course_group, 
  json.url course_group_url(course_group, format: :json)
end