json.array!(@course_sections) do |course_section|
  json.extract! course_section, 
  json.url course_section_url(course_section, format: :json)
end