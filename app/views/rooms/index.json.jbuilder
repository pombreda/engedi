json.array!(@rooms) do |room|
  json.extract! room, 
  json.url room_url(room, format: :json)
end