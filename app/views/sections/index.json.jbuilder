json.array!(@sections) do |section|
  json.extract! section, 
  json.url section_url(section, format: :json)
end