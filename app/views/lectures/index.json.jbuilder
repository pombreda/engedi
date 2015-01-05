json.array!(@lectures) do |lecture|
  json.extract! lecture, 
  json.url lecture_url(lecture, format: :json)
end